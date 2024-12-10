#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

TrailPosition = Struct.new(:x, :y, :value)

class TrailNode < Tree::TreeNode
end

def in_bounds?(col, row, map)
  col >= 0 && row >= 0 && col < map.size && row < map.first.size
end

def step_up?(current_position, next_position)
  next_position - current_position == 1
end

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
def find_trail(first_node, map, scores)
  x = first_node.name.x
  y = first_node.name.y

  return if first_node.nil?

  point_w = map[x][y - 1] if in_bounds?(x, y - 1, map)
  point_e = map[x][y + 1] if in_bounds?(x, y + 1, map)
  point_n = map[x - 1][y] if in_bounds?(x - 1, y, map)
  point_s = map[x + 1][y] if in_bounds?(x + 1, y, map)

  node_w  = TrailNode.new(point_w) unless point_w.nil?
  node_e  = TrailNode.new(point_e) unless point_e.nil?
  node_n  = TrailNode.new(point_n) unless point_n.nil?
  node_s  = TrailNode.new(point_s) unless point_s.nil?

  key = [first_node.root.name, first_node.name]
  scores[key] += 1 if first_node.name.value == 9

  first_node << node_n if node_n && step_up?(first_node.name.value, node_n.name.value)
  first_node << node_s if node_s && step_up?(first_node.name.value, node_s.name.value)
  first_node << node_w if node_w && step_up?(first_node.name.value, node_w.name.value)
  first_node << node_e if node_e && step_up?(first_node.name.value, node_e.name.value)

  first_node.children.each do |child|
    find_trail(child, map, scores) unless child.nil?
  end
end

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

# rubocop:disable Style/GlobalVars
$get.day(10)
input = File.read($o[:test] ? 'example.txt' : 'input.txt')
# rubocop:enable Style/GlobalVars

trail_map    = []
trail_starts = []
trail_scores = Hash.new(0)

input.each_line { |line| trail_map << line.strip.split('').map(&:to_i) }

trail_map.each_with_index do |line, x|
  line.each_with_index do |value, y|
    trail_position  = TrailPosition.new(x, y, value)
    trail_map[x][y] = trail_position

    trail_starts << TrailNode.new(trail_position) if value.zero?
  end
end

trail_starts.each do |start|
  find_trail(start, trail_map, trail_scores)
end

puts
puts "Part 1: #{trail_scores.size}"
puts "Part 2: #{trail_scores.values.sum}"
