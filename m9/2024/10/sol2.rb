#!/usr/bin/env ruby

require_relative '../common'

$get.day(10)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

map = []

input.each_line do |line|
  map << line.strip.split('').map { |e| if e != '.' then e.to_i else 100 end }
end

starts = []
points = []
# transformations = [
#   [-1, 0], [1, 0],
#   [0, -1], [0, 1],
# ] 

Point = Struct.new(:x, :y, :v)

new_map = Array.new(map.size) { Array.new(map[0].size) }

map.each_with_index do |line, x|
  line.each_with_index do |value, y|
    point = Point.new(x, y, value)
    new_map[x][y] = point 
    starts << Tree::TreeNode.new(point) if value == 0
  end
end

full_trails = []

def check_bounds(x, y, map)
  x >= 0 && y >= 0 && x < map.size && y < map[0].size
end

$scores = Hash.new(0)

def find_trail(start, map)
  
  x = start.name.x 
  y = start.name.y
  
  unless start.nil?

    $scores[[start.root.name, start.name]] += 1 if start.name.v == 9

    e_left = map[x][y - 1] if check_bounds(x, y - 1, map)
    e_right = map[x][y + 1] if check_bounds(x, y + 1, map)
    e_up = map[x - 1][y] if check_bounds(x - 1, y, map)
    e_down = map[x + 1][y] if check_bounds(x + 1, y, map)

    d_left = Tree::TreeNode.new(e_left) unless e_left.nil?
    d_right = Tree::TreeNode.new(e_right) unless e_right.nil?
    d_up = Tree::TreeNode.new(e_up) unless e_up.nil?
    d_down = Tree::TreeNode.new(e_down) unless e_down.nil?

    start << d_up if d_up && d_up.name.v - start.name.v == 1
    start << d_down if d_down && d_down.name.v - start.name.v == 1
    start << d_left if d_left && d_left.name.v - start.name.v == 1
    start << d_right if d_right && d_right.name.v - start.name.v == 1

    start.children.each do |child|
      find_trail(child, map) unless child.nil?
    end
  end
end

starts.each do |start|
  find_trail(start, new_map)
end

pp map 
starts.map(&:print_tree)


# full_trails.each do |t|
#   scores[t.name] += 1  
# end

ap $scores
ap $scores.values.sum
