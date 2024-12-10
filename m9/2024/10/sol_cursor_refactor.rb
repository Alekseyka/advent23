#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

TrailPosition = Struct.new(:x, :y, :value) do
  def valid_position?(map)
    x >= 0 && y >= 0 && x < map.size && y < map.first.size
  end

  def step_up?(other_value)
    other_value - value == 1
  end
end

# Represents a node in a trail path tree, extending Tree::TreeNode.
# Each node contains a TrailPosition and can have child nodes representing valid next steps.
class TrailNode < Tree::TreeNode
  # The four possible movement directions: west, east, north, south
  # @return [Array<Array<Integer>>] Array of [dx, dy] coordinate offsets
  DIRECTIONS = [[0, -1], [0, 1], [-1, 0], [1, 0]].freeze

  # Finds and adds valid neighboring positions as child nodes.
  # A valid neighbor must be in bounds and have a value exactly 1 higher than the current node.
  # @param map [Array<Array<TrailPosition>>] The 2D grid of trail positions
  # @return [void]
  def process_neighbors(map)
    DIRECTIONS.each do |dx, dy|
      neighbor = create_neighbor(dx, dy, map)
      self << neighbor if valid_neighbor?(neighbor)
    end
  end

  private

  def create_neighbor(delta_x, delta_y, trail_map)
    pos = TrailPosition.new(name.x + delta_x, name.y + delta_y)
    return unless pos.valid_position?(trail_map)

    pos.value = trail_map[pos.x][pos.y].value
    TrailNode.new(pos)
  end

  def valid_neighbor?(neighbor)
    neighbor && name.step_up?(neighbor.name.value)
  end
end

def find_trail(node, map, scores)
  return if node.nil?

  scores[[node.root.name, node.name]] += 1 if node.name.value == 9
  node.process_neighbors(map)
  node.children.each { |child| find_trail(child, map, scores) }
end

# Represents a 2D grid map of trail positions and handles finding valid paths through it.
# Each position contains a numeric value, and valid paths must increase by exactly 1 between
# adjacent positions. The map tracks start positions (value 0) and end positions (value 9).
class TrailMap
  def initialize(input)
    @map = parse_input(input)
    @starts = find_start_positions
  end

  # Processes all possible trails from start positions to end positions.
  # Returns an array containing:
  # - Number of unique trails found (size)
  # - Total number of times end positions were reached (sum)
  def process_trails
    scores = Hash.new(0)
    @starts.each { |start| find_trail(start, @map, scores) }
    [scores.size, scores.values.sum]
  end

  private

  # Converts input string into 2D array of TrailPosition objects
  # @param input [String] Multi-line string of space-separated numbers
  # @return [Array<Array<TrailPosition>>] 2D array of positions
  def parse_input(input)
    map = []
    input.each_line { |line| map << line.strip.split('').map(&:to_i) }

    map.each_with_index do |line, x|
      line.each_with_index do |value, y|
        map[x][y] = TrailPosition.new(x, y, value)
      end
    end
    map
  end

  # Finds all positions with value 0 and creates TrailNodes for them
  # @return [Array<TrailNode>] Array of starting position nodes
  def find_start_positions
    starts = []
    @map.each_with_index do |line, x|
      line.each_with_index do |pos, y|
        starts << TrailNode.new(@map[x][y]) if pos.value.zero?
      end
    end
    starts
  end
end

# rubocop:disable Style/GlobalVars
$get.day(10)
input = File.read($o[:test] ? 'example.txt' : 'input.txt')
# rubocop:enable Style/GlobalVars

trail_map = TrailMap.new(input)
part1, part2 = trail_map.process_trails

puts
puts "Part 1: #{part1}"
puts "Part 2: #{part2}"
