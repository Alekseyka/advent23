# row, col
@map= []
trailheads = []

def is_inside_map(position)
  return false if position[0] < 0 || position[1] < 0 || position[0] >= @rows || position[1] >= @cols

  true
end

def trailtail_find(position, height)
  return 0 unless is_inside_map(position)
  return 0 if @map[position[0]][position[1]] != height.to_s
  return 1 if @map[position[0]][position[1]] == height.to_s && height == 9

  q = 0
  q += trailtail_find([position[0] - 1, position[1]], height + 1)
  q += trailtail_find([position[0] + 1, position[1]], height + 1)
  q += trailtail_find([position[0], position[1] - 1], height + 1)
  q += trailtail_find([position[0], position[1] + 1], height + 1)
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
  sum += trailtail_find(trailhead, 0)
  p "#{sum} score for #{trailhead}"
end

p sum