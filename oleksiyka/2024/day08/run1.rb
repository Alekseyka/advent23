nodes = {}
map = []

File.foreach('in.txt').with_index do |line, line_index|
  line = line.sub("\n", '')
  map.push(line.chars)

  line.chars.each_with_index do |char, row_index|
    nodes[char] = nodes[char].to_a.push([line_index, row_index]) unless char == '.'
  end

end

rows = map.size
cols = map[0].size

q = 0

antinodes = []
nodes.each do |char, locations|
  locations.combination(2).to_a.each do |pair|
    p '----------bla----------'
    p "Char #{char}, pair #{pair}"
    pair0 = pair[0]
    pair1 = pair[1]
    dcols = pair0[0] - pair1[0]
    drows = pair0[1] - pair1[1]
    marker = [pair1[0] - dcols, pair1[1] - drows]
    p "MD: #{marker}"
    if marker[0] >= 0 && marker[1] >= 0 && marker[0] < cols && marker[1] < rows
      if map[marker[0]][marker[1]] != char
        map[marker[0]][marker[1]] = '#'
        antinodes.push(marker)
        p "ANTINODE: #{marker}"
      end
    end
    marker = [pair0[0] + dcols, pair0[1] + drows]
    p "MU: #{marker}"
    if marker[0] >= 0 && marker[1] >= 0 && marker[0] < cols && marker[1] < rows
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