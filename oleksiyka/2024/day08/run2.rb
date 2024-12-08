nodes = {}
map = []

antinodes = []

File.foreach('in.txt').with_index do |line, line_index|
  line = line.sub("\n", '')
  map.push(line.chars)

  line.chars.each_with_index do |char, row_index|
    unless char == '.'
      nodes[char] = nodes[char].to_a.push([line_index, row_index])
      antinodes.push([line_index, row_index])
    end
  end

end

rows = map.size
cols = map[0].size

nodes.each do |char, locations|
  locations.combination(2).to_a.each do |pair|
    p '----------bla----------'
    p "Char #{char}, pair #{pair}"
    pair0 = pair[0]
    pair1 = pair[1]
    dcols = pair0[0] - pair1[0]
    drows = pair0[1] - pair1[1]
    iteratable_cols = pair1[0]
    iteratable_rows = pair1[1]
    while true do
      iteratable_cols -= dcols
      iteratable_rows -= drows
      break if iteratable_cols < 0 || iteratable_rows < 0 || iteratable_cols >= cols || iteratable_rows >= rows
      marker = [iteratable_cols, iteratable_rows]
      p "MD: #{marker}"
      if map[marker[0]][marker[1]] != char
        map[marker[0]][marker[1]] = '#'
        antinodes.push(marker)
        p "ANTINODE: #{marker}"
      end
    end

    iteratable_cols = pair0[0]
    iteratable_rows = pair0[1]
    while true do
      iteratable_cols += dcols
      iteratable_rows += drows
      break if iteratable_cols < 0 || iteratable_rows < 0 || iteratable_cols >= cols || iteratable_rows >= rows
      marker = [iteratable_cols, iteratable_rows]
      p "MU: #{marker}"
      if map[marker[0]][marker[1]] != char
        map[marker[0]][marker[1]] = '#'
        antinodes.push(marker)
        p "ANTINODE: #{marker}"
      end
    end
  end
end


p nodes
p '---'
print_map map
p '---'
p antinodes.uniq.count