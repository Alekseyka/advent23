@map = []
@visited_positions = []
@guard_initial_direction = [-1, 0]
@guard_direction = @guard_initial_direction.dup
@guard_out = false
@guard_moves = []

@turns = {
  '0-1': [-1, 0],
  '-10': [0, 1],
  '01': [1, 0],
  '10': [0, -1]
}

def print_map(map)
  map.each { |i| puts i.join }
end

File.foreach('in.txt').with_index do |line, index|
  line = line.sub("\n", '')
  @map.push(line.split(''))
  if line.include?('^')
    @initial_guard = [index, line.index('^')]
    @guard = @initial_guard.dup
    @visited_positions.push({
                              position: @guard,
                              direction: @guard_direction
                            })
    @zero_position = {
      position: @guard,
      direction: @guard_direction
    }
  end
end

@initial_map = @map.map(&:dup)
@rows = @map.size
@cols = @map[0].size

def move_guard
  new_guard = [@guard[0] + @guard_direction[0], @guard[1] + @guard_direction[1]]
  if new_guard[0] < 0 || new_guard[1] < 0 || new_guard[0] >= @rows || new_guard[1] >= @cols
    @guard_out = true
    return
  end
  if @visited_positions.include?({ position: [new_guard[0], new_guard[1]], direction: @guard_direction })
    p "Cycle!"
    @guard_cycle = true
    return
  end
  if @map[@guard[0] + @guard_direction[0]][@guard[1] + @guard_direction[1]] != '#'
    @guard = new_guard
    @visited_positions.push({
                              position: [new_guard[0], new_guard[1]],
                              direction: @guard_direction
                            })
  else
    @guard_direction = @turns["#{@guard_direction[0]}#{@guard_direction[1]}".to_sym]
    @visited_positions.push({
                              position: [@guard[0], @guard[1]],
                              direction: @guard_direction
                            })
  end
end

until @guard_out
  move_guard
end


@possible_obstacles = @visited_positions.map {|p| p[:position]}.dup.uniq
@possible_obstacles.delete(@zero_position[:position])

q = 0
@possible_obstacles.each.with_index do |obstacle, index|
  p "O #{index} from #{@possible_obstacles.size}"
  @visited_positions = []
  @guard = @initial_guard.dup
  @guard_direction = @guard_initial_direction.dup
  @guard_out = false
  @guard_cycle = false
  @map = @initial_map.map(&:dup)
  @map[obstacle[0]][obstacle[1]] = '#'
  until @guard_out || @guard_cycle
    move_guard
  end
  if @guard_cycle
    p "Obstacle: #{obstacle}"
    q += 1
  end
end

p q