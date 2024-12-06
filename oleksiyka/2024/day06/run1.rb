@map = []
@visited_map = []
@guard = [0,0]
@guard_direction = [-1, 0]
@guard_out = false

@turns = {
  '0-1': [-1, 0],
  '-10': [0, 1],
  '01': [1, 0],
  '10': [0, -1]
}

File.foreach('in.txt').with_index do |line, index|
  line = line.sub("\n", '')
  @map.push(line)
  @visited_map.push([0] * line.length)
  if line.include?('^')
    @guard = [index, line.index('^')]
    @visited_map[index][line.index('^')] = 1
  end
end

@rows = @map.size
@cols = @map[0].size

def move_guard
  new_guard = [@guard[0] + @guard_direction[0], @guard[1] + @guard_direction[1]]
  if new_guard[0] < 0 || new_guard[1] < 0 || new_guard[0] >= @rows || new_guard[1] >= @cols
    @guard_out = true
    return
  end
  if @map[@guard[0] + @guard_direction[0]][@guard[1] + @guard_direction[1]] != '#'
    @guard = new_guard
    @visited_map[new_guard[0]][new_guard[1]] = 1
  else
    @guard_direction = @turns["#{@guard_direction[0]}#{@guard_direction[1]}".to_sym]
  end
end

until @guard_out
  move_guard
end

q = 0
@visited_map.each do |l|
  q += l.count(1)
end

p q
