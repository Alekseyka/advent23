#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

TrailPosition = Struct.new(:x, :y, :value)

class TrailNode < Tree::TreeNode
end

def in_bounds?(pos, map)
  pos.x >= 0 && pos.y >= 0 && pos.x < map.size && pos.y < map.first.size
end

def step_up?(current, next_pos)
  next_pos.value - current.value == 1
end

def get_neighbors(pos, map)
  neighbors = []
  [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |dx, dy|
    new_pos = TrailPosition.new(pos.x + dx, pos.y + dy)
    if in_bounds?(new_pos, map)
      new_pos.value = map[new_pos.x][new_pos.y].value
      neighbors << TrailNode.new(new_pos)
    end
  end
  neighbors
end

def find_trail(node, map, scores) # rubocop:disable Metrics/AbcSize
  return if node.nil?

  key = [node.root.name, node.name]
  scores[key] += 1 if node.name.value == 9

  get_neighbors(node.name, map).each do |neighbor|
    node << neighbor if step_up?(node.name, neighbor.name)
  end

  node.children.each { |child| find_trail(child, map, scores) }
end

# rubocop:disable Style/GlobalVars
$get.day(10)
input = File.read($o[:test] ? 'example.txt' : 'input.txt')
# rubocop:enable Style/GlobalVars

trail_map = []
trail_starts = []
trail_scores = Hash.new(0)

input.each_line { |line| trail_map << line.strip.split('').map(&:to_i) }

trail_map.each_with_index do |line, x|
  line.each_with_index do |value, y|
    pos = TrailPosition.new(x, y, value)
    trail_map[x][y] = pos
    trail_starts << TrailNode.new(pos) if value.zero?
  end
end

trail_starts.each { |start| find_trail(start, trail_map, trail_scores) }

puts
puts "Part 1: #{trail_scores.size}"
puts "Part 2: #{trail_scores.values.sum}"
