require "matrix"

def print_map(map)
  map.each { |i| puts i.join }
end

def step(direction)
  row = []
  rowcol = @position.dup
  while true
    row.push(@map[rowcol[0]][rowcol[1]])
    rowcol[0] += direction[0]
    rowcol[1] += direction[1]
    break if rowcol[0] < 0 || rowcol[1] < 0 || rowcol[0] >= @rows || rowcol[1] >= @cols
  end
  rowscan = row.join.scan(/^@[\.O]*#/)[0]
  return unless rowscan.include?('.')
  rowscan = rowscan.chars
  rowscan.delete_at(rowscan.index('.'))
  sorted_row = rowscan.unshift('.')

  rowcol = @position.dup
  index = 0
  while true
    @map[rowcol[0]][rowcol[1]] = sorted_row[index]
    rowcol[0] += direction[0]
    rowcol[1] += direction[1]
    index += 1
    break if index >= sorted_row.length
  end
  robot_index = sorted_row.index('@')
  @position = [@position[0] + direction[0] * robot_index, @position[1] + direction[1] * robot_index]
end

test = false
filename = test ? 'test.txt' : 'in.txt'

@map = []
@commands = []
@position = []

mode = :map

File.foreach(filename).with_index do |line, index|
  line = line.strip
  @position = [index, line.index('@')] if line.include?('@')
  @map << line.chars if mode == :map
  mode = :commands if line == ''
  @commands += line.chars if mode == :commands
end

@rows = @map.size
@cols = @map[0].size

@commands.each.with_index do |command, i|
  case command
  when '^'
    direction = [-1, 0]
  when 'v'
    direction = [1, 0]
  when '>'
    direction = [0, 1]
  when '<'
    direction = [0, -1]
  else
    raise StandardError 'wrong command'
  end
  step(direction)
end

q = 0

@map.each.with_index do |row, r_i|
  row.each.with_index do |col, c_i|
    next if col != 'O'
    q += r_i * 100 + c_i
  end
end

print_map @map
p q