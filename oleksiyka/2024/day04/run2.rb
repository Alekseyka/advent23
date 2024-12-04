grid = []
directions = [
  [1, 1],
  [-1, 1],
  [1, -1],
  [1, 1],
  [-1, -1],
  [1, -1],
]

File.foreach('in.txt') do |line|
  grid.push(line.sub("\n", ''))
end

rows = grid.size
cols = grid[0].size

targets = [
  'MASASAM',
  'MAMASAS',
  'SAMAMAS',
  'SASAMAM',
]
count = 0

(0...rows).each do |row|
  (0...cols).each do |col|
    targets.each do |target|
      next if grid[row][col] != target[0]
      p "#{target[0]} at #{row} #{col} :"
      match = true
      new_row = row
      new_col = col
      directions.each.with_index do |direction, index|
        dx = direction[0]
        dy = direction[1]

        new_row = new_row + dx
        new_col = new_col + dy

        unless new_row >= rows || new_col >= cols
          p "Check #{grid[new_row][new_col]}(#{new_row}:#{new_col}) with #{target[index+1]}(#{index+1})"
        end
        if new_row >= rows || new_col >= cols || grid[new_row][new_col] != target[index+1]
          match = false
          break
        end
      end
      if match
        p "MATCH"
        count += 1
      end
    end
  end
end

p count
