#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

def pr_gr2(grid, min)
  grid.each.with_index { |a, i| puts a.map.with_index { |_b, j| @results2[min].include?(".#{i}:#{j}:") ? '+' : '.' }.join }
end

@shortest_ways = {}
@results = []
@results2 = {}

@grid = File.read(filename).split("\n").map(&:chars)
@grid_h = @grid.length
@grid_w = @grid[0].length

@directions = [0, 90, 180, 270]
@op_dir = {
  90 => 270,
  270 => 90,
  0 => 180,
  180 => 0
}

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

go_lava = lambda do |row, col, sum, dir_before, dir_repeat, path|
  return if row.negative? || row >= @grid_h || col.negative? || col >= @grid_w

  row_col_str = [row, col, dir_before].join(':')
  path += ".#{row_col_str}"
  @results.push(sum) and (@results2[sum] = path) and return if row == @grid_h - 1 && col == @grid_w - 1

  sum += @grid[row][col].to_i
  return if sum > 700
  return if !@results.empty? && sum > @results.min

  return if !@shortest_ways[row_col_str].nil? && @shortest_ways[row_col_str].to_i <= sum

  @shortest_ways[row_col_str] = sum

  @directions.each do |direction|
    next if dir_before == direction && dir_repeat >= 3
    next if dir_before == @op_dir[direction]

    do_move.call(row, col, direction) => [new_row, new_col]
    new_dir_repeat = direction == dir_before ? dir_repeat + 1 : 1
    go_lava.call(new_row, new_col, sum, direction, new_dir_repeat, path)
  end
end

go_lava.call(0, 1, 2, 0, 2, '')
go_lava.call(1, 0, 3, 90, 2, '')
min = @results.min
pr_gr2 @grid, min
puts min - @grid[0][0].to_i
@check = 0
ap @results2[min].split('.')
