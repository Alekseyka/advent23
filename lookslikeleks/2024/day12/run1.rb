test = false
filename = test ? 'test.txt' : 'in.txt'

def print_map(map)
  p '==============='
  map.each { |i| puts i.join }
end

def is_inside_map(position)
  return false if position[0] < 0 || position[1] < 0 || position[0] >= @rows || position[1] >= @cols

  true
end

def calculate_area(row, col, type)
  return [0, 1] unless is_inside_map([row,col])
  return [0, 1] if @map[row][col] != type
  return [0, 0] if @visited_map[row][col] != '.'

  @visited_map[row][col] = type
  s = [1,0]
  up = calculate_area(row - 1, col, type)
  s[0] += up[0]
  s[1] += up[1]
  down = calculate_area(row + 1, col, type)
  s[0] += down[0]
  s[1] += down[1]
  right = calculate_area(row, col + 1, type)
  s[0] += right[0]
  s[1] += right[1]
  left = calculate_area(row, col - 1, type)
  s[0] += left[0]
  s[1] += left[1]
  s
end

@map = File.read(filename).split("\n").map(&:chars)

@rows = @map.size
@cols = @map[0].size

@visited_map = []
@cols.times do |i|
  @visited_map.push(['.'] * @rows)
end

q = 0
@map.each.with_index do |row, row_index|
  row.each.with_index do |plant_type, col_index|
    next if @visited_map[row_index][col_index] != '.'

    p "#{row_index}/#{@rows} - #{col_index}/#{@cols}"
    result = calculate_area(row_index, col_index, plant_type)
    q += result[0] * result[1]
  end
end


print_map @map
p q
