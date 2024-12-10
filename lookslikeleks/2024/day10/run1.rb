# row, col
@map= []
trailheads = []

def is_inside_map(position)
  return false if position[0] < 0 || position[1] < 0 || position[0] >= @rows || position[1] >= @cols

  true
end

def trailtail_find(position, height)
  return nil unless is_inside_map(position)
  return nil if @map[position[0]][position[1]] != height.to_s
  return [position] if @map[position[0]][position[1]] == height.to_s && height == 9

  q = []
  up = trailtail_find([position[0] - 1, position[1]], height + 1)
  q += up if up != nil
  down = trailtail_find([position[0] + 1, position[1]], height + 1)
  q += down if down != nil
  left = trailtail_find([position[0], position[1] - 1], height + 1)
  q += left if left != nil
  right = trailtail_find([position[0], position[1] + 1], height + 1)
  q += right if right != nil
  q
end

File.foreach('in.txt').with_index do |line, line_index|
  line = line.sub("\n", '')
  @map.push(line.chars)

  if line.include?('0')
    (0..line.length).find_all {|i| line[i, 1] == '0'}.each do |col|
      trailheads.push([line_index, col])
    end
  end
end

@rows = @map.size
@cols = @map[0].size

sum = 0
trailheads.each do |trailhead|
  reachable_tails = trailtail_find(trailhead, 0)
  p "#{reachable_tails.uniq.count} heads for #{trailhead}: #{reachable_tails.uniq}"
  sum += reachable_tails.uniq.count
end

p sum