#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'
STEPS = 26501365

def pr_gr(grid)
  grid.each { |i| puts i.join }
end

def pr_gr2(grid)
  grid.each.with_index { |a, i| puts a.map.with_index { |_b, j| @current_steps.find { |s| s == [i, j] } ? 'O' : @grid[i][j] }.join }
end

def do_move(row, col, direction)
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

def find_neighbours(row, col)
  neighbours = []
  [0, 90, 180, 270].each do |dir|
    do_move(row, col, dir) => [new_row, new_col]
    next if new_row.negative? || new_row >= @grid_h
    next if new_col.negative? || new_col >= @grid_w
    next if @grid[new_row][new_col] == '#'

    neighbours.push([new_row, new_col])
  end
  neighbours
end

def process_steps(steps)
  new_steps = []
  steps.each do |step|
    new_steps.push(*find_neighbours(step[0], step[1]))
  end
  new_steps
end

@grid = File.read(filename).split("\n").map(&:chars)
@grid_h = @grid.length
@grid_w = @grid[0].length

@current_steps = []
@next_steps = []

@grid.each.with_index do |row, i|
  next unless row.include?('S')

  @current_steps.push([i, row.index('S')])
end

STEPS.times do |i|
  @current_steps = process_steps(@current_steps).uniq
  print "#{i} - #{@current_steps.length}\r"
  $stdout.flush
  # ap @current_steps
  # pr_gr2 @grid
end

pr_gr2 @grid
puts @current_steps.length
