#!/usr/bin/env ruby

require 'awesome_print'

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
@maze = []
@maze_w = 0
@maze_h = 0

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
    result.push([pos0, pos1]) if @pipes[char.to_s.to_sym].include?(key.to_s)
  end
  result
end

filename = 'input.txt'
# filename = 'example.txt'

result = 0
s_position = []

File.foreach(filename).with_index do |line, index|
  @maze.push(line.sub(/\n/, '').chars)
  if (position = (line =~ /S/))
    s_position = [index, position]
  end
end
@maze_w = @maze[0].length
@maze_h = @maze.length

current_position = get_connected_pipes(s_position)[0]
previous_position = s_position
next_direction = @transitions.key([current_position[0] - previous_position[0], current_position[1] - previous_position[1]])
step = 1

loop do
  current_char = @maze[current_position[0]][current_position[1]]
  break if current_char.to_s == 'S'

  puts "Char: #{current_char}, pos: #{current_position}, change: #{next_direction.to_s.to_sym}"
  next_direction = @pipes[current_char.to_s.to_sym].join.scan(Regexp.new("[^#{@invers[next_direction.to_s.to_sym]}]"))[0]
  next_transition = @transitions[next_direction.to_sym]
  current_position = [current_position[0] + next_transition[0], current_position[1] + next_transition[1]]
  step += 1
end

puts "Result: '#{step/2}'"
