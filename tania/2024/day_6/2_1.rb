res = 0
map1 = []
pos_x = 0
pos_y = 0
direction = 'n'

def map_search(map, pos_x, pos_y, new_x, new_y)
    start_x = pos_x
    start_y = pos_y
    turns_near_x = 0
    direction = 'n'

    while turns_near_x < 5 do
        # pp "#{pos_x} #{pos_y} #{direction}"
      break unless pos_x >= 0 && pos_x < map[0].size && pos_y >= 0 && pos_y < map.size
    #   pp "#{pos_y} #{pos_x}"
      map[pos_y][pos_x] = 'X'
      if direction == "n"
       break if pos_y - 1 < 0 
       if map[pos_y - 1][pos_x] == "#"
        turns_near_x += 1 if pos_y - 1 == new_y && new_x == pos_x
        direction = "w"
       else 
        pos_y -= 1
       end
       next
      end
    
      if direction == "s"
        break if pos_y + 1 > map.size - 1
        if map[pos_y + 1][pos_x] == "#"
        turns_near_x += 1 if pos_y + 1 == new_y && new_x == pos_x
         direction = "e"
        else 
         pos_y += 1
        end 
    
        next
      end
    
      if direction == "w"
        break if pos_x + 1 > map[0].size - 1
        if map[pos_y][pos_x + 1] == "#"
            turns_near_x += 1 if pos_y == new_y && new_x == pos_x + 1
         direction = "s"
        else 
         pos_x += 1
        end  
        next
      end 
    
      if direction == "e"
        break if pos_x - 1 < 0
        if map[pos_y][pos_x - 1] == "#"
         turns_near_x += 1 if pos_y == new_y && new_x == pos_x - 1
         direction = "n"
        else 
         pos_x -= 1
        end  
        next 
      end      
    end
    # map.each do |line|
    #     pp line
    # end
    # pp "#{pos_x} #{pos_y} #{direction} #{turns_near_x}"

    return 0 if turns_near_x < 5
    return 1
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


# pp pos_x
#     pp pos_y
map1.each_with_index do |line, i|
  line.each_with_index do |c, j|
    map2 = map1.map(&:clone)
    
    # pp "#{j} #{i} map[i][j]=#{map1[i][j]}"
    if map1[i][j] != '#' && j != pos_x || i != pos_y
        map2[i][j] = "#"
        res += map_search(map2, pos_x, pos_y, j, i)
        pp "#{i} #{j} res = #{res}"
    end
  end
end

pp res