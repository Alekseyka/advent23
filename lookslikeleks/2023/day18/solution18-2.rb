#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

DIR_MAP = {
  0 => 'R',
  1 => 'D',
  2 => 'L',
  3 => 'U'
}.freeze
@steps = File.read(filename).split("\n").map do |line|
  scan = line.scan(/(\w) (\d+) \(#(.{6})\)/)[0]
  [DIR_MAP[scan[2][-1].to_i], scan[2][0..-2].to_i(16)]
  # [scan[0], scan[1].to_i]
end
# ap @steps

add_step = lambda do |row, col, step|
  case step[0]
  when 'R'
    [row, col + step[1]]
  when 'D'
    [row + step[1], col]
  when 'L'
    [row, col - step[1]]
  when 'U'
    [row - step[1], col]
  else
    puts "r: #{row}, c: #{col}, s: #{step}"
    raise StandardError 'You shouldn\'t be here'
  end
end

@coordinates = [[0, 0]]

@area = 0
@perimeter = 0
@steps.each.with_index do |step, index|
  prev_point = @coordinates[index]
  current_point = add_step.call(prev_point[0], prev_point[1], step)
  @coordinates.push(current_point)
  @area += prev_point[0] * current_point[1] - prev_point[1] * current_point[0]
  @perimeter += step[1]
end

ap @area.abs / 2 + @perimeter / 2 + 1
