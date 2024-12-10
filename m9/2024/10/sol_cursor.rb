#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

Position = Struct.new(:x, :y, :value)

def in_bounds?(x, y, map) # rubocop:disable Naming/MethodParameterName
  x >= 0 && y >= 0 && x < map.size && y < map.first.size
end

def find_trails(start_pos, map) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  scores = Hash.new(0)
  queue = [[start_pos]]

  while (path = queue.shift)
    pos = path.last
    x = pos.x
    y = pos.y

    # Track score if value is 9
    scores[[path.first, pos]] += 1 if pos.value == 9

    # Check adjacent positions
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]].each do |next_x, next_y|
      next unless in_bounds?(next_x, next_y, map)

      next_pos = map[next_x][next_y]
      next unless next_pos.value == pos.value + 1

      queue << path + [next_pos]
    end
  end

  scores
end

# rubocop:disable Style/GlobalVars
$get.day(10)
input = File.read($o[:test] ? 'example.txt' : 'input.txt')
# rubocop:enable Style/GlobalVars

map = []
starts = []

input.each_line.with_index do |line, x|
  map << line.strip.chars.map.with_index do |val, y|
    pos = Position.new(x, y, val.to_i)
    starts << pos if val == '0'
    pos
  end
end

scores = starts.flat_map { |start| find_trails(start, map) }.to_h

puts
puts "Part 1: #{scores.size}"
puts "Part 2: #{scores.values.sum}"
