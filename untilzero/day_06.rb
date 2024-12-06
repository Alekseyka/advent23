puts "Input:"

raw = STDIN.readline(sep="\0").chomp.split(/\r?\n/).map{ |v| v.split('') }

$turns = { :up => :right, :right => :down, :down => :left, :left => :up }
$lapped = { :up => false, :right => false, :down => false, :left => false}
$guards = { '^' => :up, '>' => :right, 'v' => :down, '<' => :left }
$origin = Struct.new(:x,:y).new

# find origin
raw.each_with_index do |row, y|
  if (x = row.index{ |pos| $guards.keys.include?(pos) })
    $origin.x, $origin.y = [x,y]
    break
  end
end

puts "Guard Origin: #{$origin}"

def dr_cheeks(raw) # I'm doing my rounds and I'm a little behind
  map = raw.map(&:dup)
  pos = $origin.dup
  send($guards[map[pos.y][pos.x]], map, pos)
  
  total = 0
  chars = "XO#{$guards.keys.join('')}"
  map.each do |row|
    total += row.join('').count(chars)
    puts row.join('')
  end
  
  puts "Total Distinct Positions: #{total}"
  
end

def dr_who(raw) # cause times loops or some shit
  loopers = 0
  # BRUTE (FORCE) SQUAD!
  (0 ... raw.length).each do |y|
    (0 ... raw[y].length).each do |x|
      map = raw.map(&:dup)
      if(map[y][x] == '.')        
        $lapped.transform_values!{ |v| v = false }
        map[y][x] = '#'
        loopers += 1 unless send($guards[map[$origin.y][$origin.x]], map, $origin.dup)
      end
    end
  end
  
  puts "Total Looping Positions: #{loopers}"
  
end

def up(map, pos)
  return false unless $lapped.has_value?(false)
  $lapped[__method__.to_sym] = true
  loop do
    map[pos.y][pos.x] = 'O' and return true if pos.y < 1
    return send($turns[__method__.to_sym], map, pos) if (map[pos.y - 1][pos.x] == '#')
    pos.y -= 1
    $lapped[__method__.to_sym] = false unless map[pos.y][pos.x] == 'X'
    map[pos.y][pos.x] = 'X'
  end
end

def down(map, pos)
  return false unless $lapped.has_value?(false)
  $lapped[__method__.to_sym] = true
  loop do
    map[pos.y][pos.x] = 'O' and return true if (pos.y >= (map.length - 1))
    return send($turns[__method__.to_sym], map, pos) if (map[pos.y + 1][pos.x] == '#')
    pos.y += 1
    $lapped[__method__.to_sym] = false unless map[pos.y][pos.x] == 'X'
    map[pos.y][pos.x] = 'X'
  end
end

def left(map, pos)
  return false unless $lapped.has_value?(false)
  $lapped[__method__.to_sym] = true
  loop do
    map[pos.y][pos.x] = 'O' and return true if pos.x < 1
    return send($turns[__method__.to_sym], map, pos) if (map[pos.y][pos.x - 1] == '#')
    pos.x -= 1
    $lapped[__method__.to_sym] = false unless map[pos.y][pos.x] == 'X'
    map[pos.y][pos.x] = 'X'
  end
end

def right(map, pos)
  return false unless $lapped.has_value?(false)
  $lapped[__method__.to_sym] = true
  loop do
    map[pos.y][pos.x] = 'O' and return true if (pos.x >= (map[0].length - 1))
    return send($turns[__method__.to_sym], map, pos) if (map[pos.y][pos.x + 1] == '#')
    pos.x += 1
    $lapped[__method__.to_sym] = false unless map[pos.y][pos.x] == 'X'
    map[pos.y][pos.x] = 'X'
  end
end

dr_cheeks(raw)
dr_who(raw)
