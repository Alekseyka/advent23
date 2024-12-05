puts "Input:"

raw = STDIN.readline(sep="\0").chomp.split(/\r?\n/)

rows = raw.dup
grid = rows.map{ |v| v.split('') }
cols = grid.transpose.map(&:join)

total = 0


# find all horizontal instances
total += rows.map{ |v| v.scan(/XMAS/).length }.sum
total += rows.map{ |v| v.scan(/SAMX/).length }.sum
# find all vertical instances
total += cols.map{ |v| v.scan(/XMAS/).length }.sum
total += cols.map{ |v| v.scan(/SAMX/).length }.sum



def diagonal_up(grid, row, col, word)
  letters = word.split('')
  length = letters.length - 1
  return false if (length > row)
  (0 .. length).each do |i|
    r = row - i
    c = col + i
    return false unless (letters[i] == grid.dig(r,c))
  end
  true
end

def diagonal_down(grid, row, col, word)
  letters = word.split('')
  (0 ... letters.length).each do |i|
    r = row + i
    c = col + i
    return false unless (letters[i] == grid.dig(r,c))
  end
  true
end

grid.each_with_index do |row, r|
  row.each_with_index do |col, c|
    total += 1 if diagonal_up(grid, r, c, 'XMAS')
    total += 1 if diagonal_up(grid, r, c, 'SAMX')
    total += 1 if diagonal_down(grid, r, c, 'XMAS')
    total += 1 if diagonal_down(grid, r, c, 'SAMX')    
  end
end

puts "Total XMAS: #{total}"

total = 0
grid.each_with_index do |row, r|
  row.each_with_index do |col, c|
    if (diagonal_down(grid, r, c, 'MAS') || diagonal_down(grid, r, c, 'SAM'))
      total += 1 if (diagonal_up(grid, r+2, c, 'MAS') || diagonal_up(grid, r+2, c, 'SAM'))
    end
  end
end

puts "Total X-'MAS': #{total}"
