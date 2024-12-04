grid = []
directions = [
  [0, 1],
  [1, 0],
  [1, 1],
  [-1, 1],
  [0, -1],
  [-1, 0],
  [-1, -1],
  [1, -1]
]

File.foreach('test.txt') do |line|
  grid.push(line.sub("\n", ''))
end

rows = grid.size
cols = grid[0].size

target = 'XMAS'
count = 0

(0...rows).each do |row|
  (0...cols).each do |col|
    directions.each do |dx, dy|
      match = true
      (0...target.length).each do |i|
        new_row = row + i * dx
        new_col = col + i * dy
        if new_row < 0 || new_row >= rows || new_col < 0 || new_col >= cols || grid[new_row][new_col] != target[i]
          match = false
          break
        end
      end
      if match
        p "MATCH! (#{row},#{col}: #{dx}:#{dy})"
        count += 1
      end
    end
  end
end

p count
