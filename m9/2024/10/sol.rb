#!/usr/bin/env ruby
require_relative '../common'

TrailPosition = Struct.new(:x, :y, :value)

class TrailNode < Tree::TreeNode 
end

def is_in_bounds?(x, y, map)
  x >= 0 && y >= 0 && x < map.size && y < map.first.size
end

def is_step_up?(current_position, next_position)
  1 == next_position - current_position 
end

def find_trail(first_node, map, scores)

  x = first_node.name.x
  y = first_node.name.y

  unless first_node.nil?

    scores[[first_node.root.name, first_node.name]] += 1 if first_node.name.value == 9

    point_w = map[x][y - 1] if is_in_bounds?(x, y - 1, map)
    point_e = map[x][y + 1] if is_in_bounds?(x, y + 1, map)
    point_n = map[x - 1][y] if is_in_bounds?(x - 1, y, map)
    point_s = map[x + 1][y] if is_in_bounds?(x + 1, y, map)

    node_w = TrailNode.new(point_w) unless point_w.nil?
    node_e = TrailNode.new(point_e) unless point_e.nil?
    node_n = TrailNode.new(point_n) unless point_n.nil?
    node_s = TrailNode.new(point_s) unless point_s.nil?

    first_node << node_n if node_n && is_step_up?(first_node.name.value, node_n.name.value)
    first_node << node_s if node_s && is_step_up?(first_node.name.value, node_s.name.value)
    first_node << node_w if node_w && is_step_up?(first_node.name.value, node_w.name.value)
    first_node << node_e if node_e && is_step_up?(first_node.name.value, node_e.name.value)

    first_node.children.each do |child|
      find_trail(child, map, scores) unless child.nil?
    end
  end
end

$get.day(10)
input = File.read($o[:test] ? 'example.txt' : 'input.txt')

trail_map    = []
trail_starts = []
trail_scores = Hash.new(0)

input.each_line { |line| trail_map << line.strip.split('').map(&:to_i) }

trail_map.each_with_index do |line, x|
  line.each_with_index do |value, y|
    trail_position  = TrailPosition.new(x, y, value)
    trail_map[x][y] = trail_position
    
    trail_starts   << TrailNode.new(trail_position) if value == 0
  end
end

trail_starts.each do |start|
  find_trail(start, trail_map, trail_scores)
end

puts 
puts "Part 1: #{trail_scores.size}"
puts "Part 2: #{trail_scores.values.sum}"
