res = 0
map1 = []
pos_x = 0
pos_y = 0
direction = 'n'

def map_search(map, pos_x, pos_y, new_x, new_y)
    start_x = new_x
    start_y = new_y
    direction = 'n'
    visited = {}
    cycle = false
   

    while 1 < 2 do
        if visited["#{pos_y};#{pos_x}"].nil?
            visited["#{pos_y};#{pos_x}"] = 1
        else 
            visited["#{pos_y};#{pos_x}"] += 1
        end

      if visited["#{pos_y};#{pos_x}"] >= 5
        cycle = true
        break
      end

      break unless pos_x >= 0 && pos_x < map[0].size && pos_y >= 0 && pos_y < map.size
      map[pos_y][pos_x] = 'X'

      if direction == "n"
       break if pos_y - 1 < 0 
       if map[pos_y - 1][pos_x] == "#"
        direction = "w"
       else 
        pos_y -= 1
       end
       next
      end
    
      if direction == "s"
        break if pos_y + 1 > map.size - 1
        if map[pos_y + 1][pos_x] == "#"
         direction = "e"
        else 
         pos_y += 1
        end 
    
        next
      end
    
      if direction == "w"
        break if pos_x + 1 > map[0].size - 1
        if map[pos_y][pos_x + 1] == "#"
         direction = "s"
        else 
         next_x = map[pos_y][(pos_x + 1).. -1].index("#")
         pos_x = if next_x.nil?
            map[0].size
         else 
            pos_x += next_x 
         end
        end  
        next
      end 
    
      if direction == "e"
        break if pos_x - 1 < 0
        if map[pos_y][pos_x - 1] == "#"
         direction = "n"
        else
         next_x = map[pos_y][0..(pos_x - 1)].reverse.index("#")
         pos_x = if next_x.nil?
            -1
         else 
            pos_x - next_x
         end
        end  
        next 
      end      
    end

    return 1 if cycle == true
    return 0
end

File.open('input2.txt', 'r') do |file|
    index = 0
    file.each_line do |line|
      line.strip!
      map1 << line.chars
      if line.index("^") 
        pos_x = line.index("^")
        pos_y = index
      end
      index += 1
    end
end


map1.each_with_index do |line, i|
  line.each_with_index do |c, j|
    map2 = map1.map(&:clone)
    
    if map1[i][j] != '#' && j != pos_x || i != pos_y
        map2[i][j] = "#"
        res += map_search(map2, pos_x, pos_y, j, i)
    end
  end
end

pp res