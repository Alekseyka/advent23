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
  return [0, 1] unless is_inside_map([row, col])
  return [0, 1] if @map[row][col] != type
  return [0, 0] if @visited_map[row][col] != '.'

  @visited_map[row][col] = type
  s = [1, 0]
  up = calculate_area(row - 1, col, type)
  s[0] += up[0]
  s[1] += up[1]
  if up == [0, 1]
    @boundaries[:up] += [[row, col]]
  end
  down = calculate_area(row + 1, col, type)
  s[0] += down[0]
  s[1] += down[1]
  if down == [0, 1]
    @boundaries[:down] += [[row, col]]
  end
  right = calculate_area(row, col + 1, type)
  s[0] += right[0]
  s[1] += right[1]
  if right == [0, 1]
    @boundaries[:right] += [[row, col]]
  end
  left = calculate_area(row, col - 1, type)
  s[0] += left[0]
  s[1] += left[1]
  if left == [0, 1]
    @boundaries[:left] += [[row, col]]
  end
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
    @boundaries = { up: [], down: [], right: [], left: [] }
    result = calculate_area(row_index, col_index, plant_type)
    %i[up down right left].each do |side|
      @boundaries[side].sort_by! { |x, y| [x,y] }
    end
    index_shift = 0
    (0..(@boundaries[:up].size-1)).each do |i|
      b = @boundaries[:up][i - index_shift]
      if @boundaries[:up].include?([b[0], b[1] - 1]) || @boundaries[:up].include?([b[0], b[1] + 1])
        @boundaries[:up].delete_at(i - index_shift)
        index_shift += 1
      end
    end
    index_shift = 0
    (0..(@boundaries[:down].size-1)).each do |i|
      b = @boundaries[:down][i - index_shift]
      if @boundaries[:down].include?([b[0], b[1] - 1]) || @boundaries[:down].include?([b[0], b[1] + 1])
        @boundaries[:down].delete_at(i - index_shift)
        index_shift += 1
      end
    end
    index_shift = 0
    (0..(@boundaries[:right].size-1)).each do |i|
      b = @boundaries[:right][i - index_shift]
      if @boundaries[:right].include?([b[0] - 1, b[1]]) || @boundaries[:right].include?([b[0] + 1, b[1]])
        @boundaries[:right].delete_at(i - index_shift)
        index_shift += 1
      end
    end
    index_shift = 0
    (0..(@boundaries[:left].size-1)).each do |i|
      b = @boundaries[:left][i - index_shift]
      if @boundaries[:left].include?([b[0] - 1, b[1]]) || @boundaries[:left].include?([b[0] + 1, b[1]])
        @boundaries[:left].delete_at(i - index_shift)
        index_shift += 1
      end
    end
    boundaries_amount = @boundaries.map { |_k, v| v.size }.sum
    # p "#{plant_type} - #{boundaries_amount} - #{@boundaries}"
    q += result[0] * boundaries_amount
  end
end

p q
