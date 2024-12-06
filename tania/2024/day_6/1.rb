res = 0
map = []
pos_x = 0
pos_y = 0
direction = 'n'

File.open('input2.txt', 'r') do |file|
    index = 0
    file.each_line do |line|
      line.strip!
      map << line.chars
      if line.index("^") 
        pos_x = line.index("^")
        pos_y = index
      end
      index += 1
    end
end

while pos_x >= 0 && pos_x < map[0].size && pos_y >= 0 && pos_y < map.size do
    pp "#{pos_x} #{pos_y} #{direction}"
  map[pos_y][pos_x] = 'X'
  if direction == "n"
   break if pos_y - 1 < 0 
   if map[pos_y - 1][pos_x] == "#"
    direction = "w"
    pos_x += 1
   else 
    pos_y -= 1
   end
   next
  end

  if direction == "s"
    break if pos_y + 1 > map.size - 1
    if map[pos_y + 1][pos_x] == "#"
     direction = "e"
     pos_x -= 1
    else 
     pos_y += 1
    end 

    next
  end

  if direction == "w"
    break if pos_x + 1 > map[0].size - 1
    if map[pos_y][pos_x + 1] == "#"
     direction = "s"
     pos_y += 1
    else 
     pos_x += 1
    end  
    next
  end 

  if direction == "e"
    break if pos_x - 1 < 0
    if map[pos_y][pos_x - 1] == "#"
     direction = "n"
     pos_y -= 1
    else 
     pos_x -= 1
    end  
    next 
  end
  break unless pos_x >= 0 && pos_x < map[0].size && pos_y >= 0 && pos_y < map.size
  
end

map.each do |line|
  res += line.select{|c| c == 'X'}.size
end

pp res