#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

@transitions = {
  'U': [-1, 0],
  'R': [0, 1],
  'D': [1, 0],
  'L': [0, -1]
}
@invers = {
  'U': 'D',
  'D': 'U',
  'R': 'L',
  'L': 'R'
}
@pipes = {
  '|': %w[U D],
  '-': %w[L R],
  'L': %w[U R],
  'J': %w[U L],
  '7': %w[L D],
  'F': %w[R D],
  '.': %w[],
  'S': %w[]
}
@transformations = {
  '|': [%w[. + .], %w[. + .], %w[. + .]],
  '-': [%w[. . .], %w[+ + +], %w[. . .]],
  'L': [%w[. + .], %w[. + +], %w[. . .]],
  'J': [%w[. + .], %w[+ + .], %w[. . .]],
  '7': [%w[. . .], %w[+ + .], %w[. + .]],
  'F': [%w[. . .], %w[. + +], %w[. + .]],
  '.': [%w[. . .], %w[. . .], %w[. . .]]
}
@loop_transformations = {
  '|': [%w[, * ,], %w[, * ,], %w[, * ,]],
  '-': [%w[, , ,], %w[* * *], %w[, , ,]],
  'L': [%w[, * ,], %w[, * *], %w[, , ,]],
  'J': [%w[, * ,], %w[* * ,], %w[, , ,]],
  '7': [%w[, , ,], %w[* * ,], %w[, * ,]],
  'F': [%w[, , ,], %w[, * *], %w[, * ,]],
  '.': [%w[, , ,], %w[, , ,], %w[, , ,]]
}
@transformations[:S] = filename == 'input.txt' ? @transformations[:L] : @transformations[:'7']
@loop_transformations[:S] = filename == 'input.txt' ? @loop_transformations[:L] : @loop_transformations[:'7']
@maze = []
@alt_maze = []
@maze_w = 0
@maze_h = 0
@loop_tiles = []

def print_maze(maze)
  maze.each { |i| puts i.join }
end

def get_connected_pipes(position)
  result = []
  @transitions.each do |key, tr|
    pos0 = position[0] + tr[0]
    pos1 = position[1] + tr[1]
    next if pos0.negative? || pos0 >= @maze_h
    next if pos1.negative? || pos1 >= @maze_w

    char = @maze[pos0][pos1]
    result.push([pos0, pos1]) if @pipes[char.to_s.to_sym].include?(@invers[key.to_sym].to_s)
  end
  result
end

result = 0
s_position = []

File.foreach(filename).with_index do |line, row|
  @maze.push(line.sub(/\n/, '').chars)
  3.times do |i|
    @alt_maze.push(line.sub(/\n/, '').chars.map { |char| @transformations[char.to_s.to_sym][i] }.flatten)
  end
  if (column = (line =~ /S/))
    s_position = [row, column]
    @loop_tiles.push([row, column])
  end
end
@maze_w = @maze[0].length
@maze_h = @maze.length
@alt_maze_w = @alt_maze[0].length
@alt_maze_h = @alt_maze.length

current_position = get_connected_pipes(s_position)[0]
previous_position = s_position
next_direction = @transitions.key([current_position[0] - previous_position[0], current_position[1] - previous_position[1]])
step = 1

loop do
  current_char = @maze[current_position[0]][current_position[1]]
  3.times do |i|
    3.times do |j|
      @alt_maze[current_position[0] * 3 + i][current_position[1] * 3 + j] = @loop_transformations[current_char.to_s.to_sym][i][j]
    end
  end
  @loop_tiles.push(current_position) unless current_char.to_s == 'S'
  break if current_char.to_s == 'S'

  next_direction = @pipes[current_char.to_s.to_sym].join.scan(Regexp.new("[^#{@invers[next_direction.to_s.to_sym]}]"))[0]
  next_transition = @transitions[next_direction.to_sym]
  current_position = [current_position[0] + next_transition[0], current_position[1] + next_transition[1]]
  step += 1
end

def mark_open(index0, index1)
  return :open if @open_found
  return :open if index0.negative? || index0 >= @alt_maze_h
  return :open if index1.negative? || index1 >= @alt_maze_w
  return :open if @alt_maze[index0][index1] == ' '
  return if %w[* ? x].include?(@alt_maze[index0][index1])

  @chars.push([index0, index1])
  @alt_maze[index0][index1] = '?'

  a = mark_open(index0 - 1, index1)
  b = mark_open(index0 + 1, index1)
  c = mark_open(index0, index1 - 1)
  d = mark_open(index0, index1 + 1)

  @open_found = true if [a, b, c, d].include?(:open)
  @open_found ? :open : nil
end

@log = false
@alt_maze.each.with_index do |line, index0|
  line.each.with_index do |char, index1|
    next if [' ', '*', 'x'].include?(char)

    @chars = []
    @open_found = false
    mark_open(index0, index1)
    @chars.each { |i| @alt_maze[i[0]][i[1]] = @open_found ? ' ' : 'x' }
  end
end

@enclosed = 0
@maze.each.with_index do |row, row_index|
  row.each.with_index do |col, col_index|
    @all_x = true
    3.times do |i|
      3.times do |j|
        @all_x = false if @alt_maze[row_index * 3 + i][col_index * 3 + j] != 'x'
      end
    end
    @enclosed += 1 if @all_x
  end
end

print_maze @alt_maze
puts "result #{@enclosed}"
