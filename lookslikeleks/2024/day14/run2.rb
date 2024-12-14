require "matrix"

def print_map(map)
  map.each { |i| puts i.join }
end

class Robot
  FIELD_X = 101
  FIELD_Y = 103
  attr_reader :position

  def initialize(position, vector)
    @position = Vector.elements(position)
    @vector = Vector.elements(vector)
  end

  def step
    new_position = @position + @vector
    @position = Vector[new_position[0] % FIELD_X, new_position[1] % FIELD_Y]
  end
end

test = false
filename = test ? 'test.txt' : 'in.txt'

robots = []

File.foreach(filename) do |line|
  line = line.strip
  scan = line.scan(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
  robots.push(Robot.new([scan[0], scan[1]], [scan[2], scan[3]]))
end

steps = 0
q = 0
while q < 1 do
  positions = []
  robots.each do |robot|
    robot.step
    positions.push(robot.position.to_a)
  end
  steps += 1
  if positions.uniq.count == positions.count
    map = []
    Robot::FIELD_Y.times do
      map.push(['.'] * Robot::FIELD_X)
    end
    q += 1
    robots.each do |robot|
      map[robot.position[1]][robot.position[0]] = 1
    end
    print_map map
    p '==============='
  end
end
