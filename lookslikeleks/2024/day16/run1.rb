require "matrix"

@direction = {
  '[-1, 0]' => [
    [[-1, 0], 1],
    [[0, 1], 1001],
    [[0, -1], 1001]
  ],
  '[1, 0]' => [
    [[1, 0], 1],
    [[0, 1], 1001],
    [[0, -1], 1001]
  ],
  '[0, 1]' => [
    [[0, 1], 1],
    [[1, 0], 1001],
    [[-1, 0], 1001]
  ],
  '[0, -1]' => [
    [[0, -1], 1],
    [[1, 0], 1001],
    [[-1, 0], 1001]
  ]
}

def print_map(map)
  map.each { |i| puts i.join('|') }
end

def map_object(map, position)
  map[position[0]][position[1]]
end

def find_end(position, direction, points)
  m_o = map_object(@map, position)
  pm_o = map_object(@point_map, position)
  return nil if m_o == '#'
  return nil if pm_o != -1 && pm_o < points
  return points if m_o == 'E'

  @point_map[position[0]][position[1]] = points

  results = []
  @direction[direction.to_s].each do |new_direction|
    new_position = position + Vector.elements(new_direction[0])
    result = find_end(new_position, new_direction[0], points + new_direction[1])
    results.push result if result != nil
  end

  results.length ? results.compact.min : nil
end

test = false
filename = test ? 'test.txt' : 'in.txt'

@map = []
@point_map = []
@start_point = []

File.foreach(filename).with_index do |line, index|
  line = line.strip
  @map << line.chars
  @point_map << [-1] * line.length
  @start_point = Vector.elements([index, line.index('S')]) if line.include?('S')
end

q = find_end(@start_point, [0, 1], 0)

print_map @map
p '==============='
print_map @point_map
p q