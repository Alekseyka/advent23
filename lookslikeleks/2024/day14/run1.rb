require "matrix"

def print_map(map)
  map.each { |i| puts i.join }
end

class Robot
  FIELD_X = 101
  FIELD_Y = 103
  STEPS = 100

  def initialize(position, vector)
    @position = Vector.elements(position)
    @vector = Vector.elements(vector)
  end

  def n_steps
    new_position = @position + @vector * STEPS
    Vector[new_position[0] % FIELD_X, new_position[1] % FIELD_Y]
  end
end

test = false
filename = test ? 'test.txt' : 'in.txt'

@map = []
Robot::FIELD_Y.times do
  @map.push(['.'] * Robot::FIELD_X)
end

q = [0, 0, 0, 0]

File.foreach(filename) do |line|
  line = line.strip
  scan = line.scan(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)[0].map(&:to_i)
  robot = Robot.new([scan[0], scan[1]], [scan[2], scan[3]])
  new_position = robot.n_steps

  mid_x = Robot::FIELD_X / 2
  mid_y = Robot::FIELD_Y / 2
  if new_position[0] < mid_x && new_position[1] < mid_y
    q[0] += 1
  elsif new_position[0] > mid_x && new_position[1] < mid_y
    q[1] += 1
  elsif new_position[0] > mid_x && new_position[1] > mid_y
    q[2] += 1
  elsif new_position[0] < mid_x && new_position[1] > mid_y
    q[3] += 1
  end

  if @map[new_position[1]][new_position[0]] == '.'
    @map[new_position[1]][new_position[0]] = 1
  else
    @map[new_position[1]][new_position[0]] += 1
  end
end

# print_map(@map)
p q
p q.inject(:*)
