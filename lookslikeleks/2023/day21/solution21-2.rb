#!/usr/bin/env ruby

require 'awesome_print'
require 'json'

# filename = 'input.txt'
filename = 'example.txt'
STEPS = 50

def pr_gr(grid)
  grid.each { |i| puts i.join }
end

def pr_gr2(grid, gr_r, gr_c)
  grid.each.with_index { |a, i| puts a.map.with_index { |_b, j| @current_steps.find { |s| s[:row] == i && s[:col] == j && s[:gr_r] == gr_r && s[:gr_c] == gr_c } ? 'O' : @grid[i][j] }.join }
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

def find_neighbours(step)
  neighbours = []
  [0, 90, 180, 270].each do |dir|
    do_move(step[:row], step[:col], dir) => [new_row, new_col]
    new_gr_r = step[:gr_r]
    new_gr_c = step[:gr_c]

    if new_row.negative?
      new_row = @grid_h - 1
      new_gr_c -= 1
    elsif new_row >= @grid_h
      new_row = 0
      new_gr_c += 1
    end
    if new_col.negative?
      new_col = @grid_w - 1
      new_gr_r -= 1
    elsif new_col >= @grid_w
      new_col = 0
      new_gr_r += 1
    end

    next if @grid[new_row][new_col] == '#'

    neighbours.push({
                      row: new_row,
                      col: new_col,
                      gr_r: new_gr_r,
                      gr_c: new_gr_c
                    })
  end
  neighbours
end

def process_steps(steps)
  new_steps = []
  steps.each do |step|
    new_steps.push(*find_neighbours(step))
  end
  new_steps
end

@grid = File.read(filename).split("\n").map(&:chars)
@grid_h = @grid.length
@grid_w = @grid[0].length

@current_steps = []

@grid.each.with_index do |row, i|
  next unless row.include?('S')

  @current_steps.push({ row: i, col: row.index('S'), gr_r: 0, gr_c: 0 })
end

STEPS.times do |i|
  @current_steps = process_steps(@current_steps).uniq
  puts "#{i + 1} - #{@current_steps.length}"
  puts @current_steps.to_json if i > 6
  # pr_gr2 @grid, 0, 0 if i > 6
  # puts '--'
  pr_gr2 @grid, -1, 0 if i > 6
end

pr_gr2 @grid, 0, 0
puts @current_steps.length
