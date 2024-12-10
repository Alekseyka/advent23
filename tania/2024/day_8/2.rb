res = 0
map1 = []
ants = {}
$antipods = []


def find_antipods(p1, p2)
   y1, x1 = p1[:lin], p1[:col]
   y2, x2 = p2[:lin], p2[:col]
   pp "y1 #{y1}, x1 #{x1}"
   pp "y2 #{y2}, x2 #{x2}"

   dx1 = x1 - x2
   dy1 = y1 - y2 
   x3 = x1 + dx1
   y3 = y1 + dy1
  
   while (x3 < $antipods[0].size && x3 >= 0 && y3 >= 0 && y3 < $antipods.size)
    $antipods[y3][x3] = "#" if y3 >= 0 && y3 < $antipods.size && x3 >= 0 && x3 < $antipods[0].size
    x3 += dx1
    y3 += dy1
   end

   dx2 = x2 - x1
   dy2 = y2 - y1
   x4 = x2 + dx2
   y4 = y2 + dy2
   

   while (x4 < $antipods[0].size && x4 >= 0 && y4 >= 0 && y4 < $antipods.size)
    $antipods[y4][x4] = "#" if y4 >= 0 && y4 < $antipods.size && x4 >= 0 && x4 < $antipods[0].size
    x4 += dx2
    y4 += dy2
   end

end

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
     map1 << line.strip.chars
    end
end

$antipods = map1.map(&:clone)

map1.each_with_index do |line, line_n|
    line.each_with_index do |c, col_n|
        if c != '.'
            if ants[c].nil?
                ants[c] = [{lin: line_n, col: col_n}]
            else 
                ants[c] << {lin: line_n, col: col_n}
            end
        end
    end
end
ants_num = 0
ants.keys.each do |ant|
    ants_num += ants[ant].size
  ants[ant].each_with_index do |coord1, index|
   ants[ant][(index + 1)..-1].each { |coord2| pp coord2; find_antipods(coord1, coord2)}
  end
end
# pp ants
# pp ants_num
$antipods.each do |line|
    res += line.select {|c| c != "."}.size

end

pp res 