#!/usr/bin/env ruby

require 'awesome_print'

# filename = 'input.txt'
filename = 'example.txt'

def pr_gr(grid)
  grid.each { |i| puts i.map { |c| c.nil? ? '.' : c }.join }
end

@steps = File.read(filename).split("\n").map { |line| line.scan(/(\w) (\d+) \(#(.{6})\)/)[0] }
# ap @steps
@grid = []
@grid_max_w = 0

do_move = lambda do |row, col, direction|
  case direction
  when 'R'
    [row, col + 1]
  when 'D'
    [row + 1, col]
  when 'L'
    [row, col - 1]
  when 'U'
    [row - 1, col]
  else
    puts "r: #{row}, c: #{col}, d: #{direction}"
    raise StandardError 'You shouldn\'t be here'
  end
end

do_step = lambda do |row, col, step|
  step[1].to_i.times do
    @grid[col] = @grid[col].to_a
    @grid[col][row] = '#'
    @grid_max_w = row if row > @grid_max_w
    # puts "r: #{row}, c: #{col}, s: #{step}"
    do_move.call(row, col, step[0]) => [row, col]
  end
  [row, col]
end

@row = 0#205
@col = 0#17
@steps.each do |step|
  result = do_step.call(@row, @col, step)
  @row = result[0]
  @col = result[1]
end

@grid = @grid.map do |row|
  if row.nil?
    row = []
    row[@grid_max_w] = nil
  else
    row[@grid_max_w] = row[@grid_max_w].nil? ? nil : row[@grid_max_w]
  end
  row
end
@grid_max_h = @grid.length
def mark_open(row, col)
  return :open if @open_found
  return :open if row.negative? || row > @grid_max_h
  return :open if col.negative? || col > @grid_max_w
  return if %w[? #].include?(@grid[row][col])

  @chars.push([row, col])
  @grid[row][col] = '?'

  a = mark_open(row - 1, col)
  b = mark_open(row + 1, col)
  c = mark_open(row, col - 1)
  d = mark_open(row, col + 1)

  @open_found = true if [a, b, c, d].include?(:open)
  @open_found ? :open : nil
end

@chars = []
@open_found = false
mark_open(4, 4)
@chars.each { |i| @grid[i[0]][i[1]] = @open_found ? ' ' : '#' }


pr_gr @grid

@result = 0
@grid.each do |row|
  @result += row.join.count('#')
end

ap @result
