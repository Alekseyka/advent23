#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

@results = []
@grid = File.read(filename).split("\n").map(&:chars)
@grid_h = @grid.length
@grid_w = @grid[0].length

#   270
# 180   0
#    90
CIRCLE = 360

reflect = lambda do |char, direction|
  case char
  when '.'
    [direction]
  when '/'
    [(270 - direction) % CIRCLE]
  when '\\'
    case direction
    when 0
      [90]
    when 90
      [0]
    when 180
      [270]
    when 270
      [180]
    end
  when '|'
    if [90, 270].include?(direction)
      [direction]
    else
      [(direction + 90) % CIRCLE, (direction - 90) % CIRCLE]
    end
  when '-'
    if [0, 180].include?(direction)
      [direction]
    else
      [(direction + 90) % CIRCLE, (direction - 90) % CIRCLE]
    end
  else
    puts "c: #{char}, d: #{direction}"
    raise StandardError 'You shouldn\'t be here'
  end
end

do_move = lambda do |row, col, direction|
  case direction
  when 0
    [row, col + 1]
  when 90
    [row + 1, col]
  when 180
    [row, col - 1]
  when 270
    [row - 1, col]
  else
    puts "r: #{row}, c: #{col}, d: #{direction}"
    raise StandardError 'You shouldn\'t be here'
  end
end

go_beam = lambda do |row, col, direction|
  return if row.negative? || row >= @grid.length || col.negative? || col >= @grid[0].length
  return unless @memo[[row, col, direction].join(':')].nil?

  @memo[[row, col, direction].join(':')] = 1
  @beams_were_here[[row, col].join(':')] = 1
  char = @grid[row][col]
  new_directions = reflect.call(char, direction)
  new_directions.each do |new_direction|
    do_move.call(row, col, new_direction) => [new_row, new_col]
    go_beam.call(new_row, new_col, new_direction)
  end
end

@grid_h.times do |i|
  @beams_were_here = {}
  @memo = {}
  go_beam.call(i, 0, 0)
  @results.push(@beams_were_here.values.sum)
  @beams_were_here = {}
  @memo = {}
  go_beam.call(i, @grid_w - 1, 180)
  @results.push(@beams_were_here.values.sum)
end
@grid_w.times do |i|
  @beams_were_here = {}
  @memo = {}
  go_beam.call(0, i, 90)
  @results.push(@beams_were_here.values.sum)
  @beams_were_here = {}
  @memo = {}
  go_beam.call(@grid_h - 1, i, 270)
  @results.push(@beams_were_here.values.sum)
end

ap @results.max
