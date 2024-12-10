res = 0
map1 = []
ants = {}
$antipods = []

def line(p1, p2)
    y1, x1 = p1[:lin], p1[:col]
    y2, x2 = p2[:lin], p2[:col]
    k = (y2 - y1).to_f / (x2 - x1).to_f
    b = y1 - k*x1 
    return {b: b, k: k}
end

def dist(x1, y1, x2, y2)
   Math.sqrt((x2- x1)**2 + (y2 - y1)**2)
end

def find_antipods(p1, p2)
#    k = line(p1, p2)[:k]
#    b = line(p1, p2)[:b]
#    pp "k #{k}, b #{b}"
   y1, x1 = p1[:lin], p1[:col]
   y2, x2 = p2[:lin], p2[:col]
   pp "y1 #{y1}, x1 #{x1}"
   pp "y2 #{y2}, x2 #{x2}"

   dx1 = x1 - x2
   dy1 = y1 - y2 
   x3 = x1 + dx1
   y3 = y1 + dy1
   $antipods[y3][x3] = "#" if y3 >= 0 && y3 < $antipods.size && x3 >= 0 && x3 < $antipods[0].size

   dx2 = x2 - x1
   dy2 = y2 - y1
   x4 = x2 + dx2
   y4 = y2 + dy2
   $antipods[y4][x4] = "#" if y4 >= 0 && y4 < $antipods.size && x4 >= 0 && x4 < $antipods[0].size


#    ant_size = $antipods[0].size
#    (0..(ant_size - 1)).each do |x|
#      y = k*x + b 
#      pp "y #{y}, x #{x}"
#     #  pp "d1: #{dist(x, y, x1, y1)} d2: #{dist(x, y, x2, y2)}"
#      if y < $antipods.size && y >= 0 && (y % 1).zero? && dist(x, y, x1, y1) == 2*dist(x, y, x2, y2)
#         $antipods[y][x] = "#"
#         break
#      end
#    end

#    (0..(ant_size - 1)).each do |x|
#     y = k*x + b 
#     pp "y #{y}, x #{x}"
#     #  pp "d1: #{dist(x, y, x1, y1)} d2: #{dist(x, y, x2, y2)}"
#     if y < $antipods.size && y >= 0 && (y % 1).zero? && 2*dist(x, y, x1, y1) == dist(x, y, x2, y2)
#        $antipods[y][x] = "#"
#        break
#     end
    
#   end
#   $antipods.each do |line|
#     pp line.join("")
#      end

#    d1 = (6*k*b + 8*x2 - 2*x1)*(6*k*b + 8*x2 - 2*x1) - 4*(-3)*(-1)*(x2*x2 -x1*x1 + y2*y2 - y1*y1 + 3*b*b + b*y1 + 4*b*y2)
#     pp d1
#    x3_1 = (-(6*k+b + 8*x2 - 2*x1) + Math.sqrt(d1))/-6
#    x3_2 = (-(6*k+b + 8*x2 - 2*x1) - Math.sqrt(d1))/-6
#    y3_1 = x3_1* k + b 
#    y3_2 = x3_1*k + b
#    pp "y3_1 #{y3_1}, x3_1 #{x3_1}"
#    pp "y3_2 #{y3_2}, x3_2 #{x2_2}"
#    x3 = ((y2*y2 - y1*y1 + x2*x2 - x1*x1)/2 - b*y1 - b*y2) / (-1*x1 - k*y1 + x2 +k*y2)
#    y3 = k*x3 + b
#    x4 = ((y1*y1 - y2*y2 + x1*x1 - x2*x2)/2 - b*y1 - b*y2) / (-1*x2 - k*y2 + x1 +k*y1)
#    y4 = k*x4 + b
#    pp "y3 #{y3}, x3 #{x3}"
#    pp "y4 #{y4}, x4 #{x4}"
#    $antipods[y4][x4] = "#" if y4 >= 0 && y4 < $antipods.size && x4 >= 0 && x4 < $antipods[0].size
#    $antipods[y3][x3] = "#" if y3 >= 0 && y3 < $antipods.size && x3 >= 0 && x3 < $antipods[0].size
end

File.open('input.txt', 'r') do |file|
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
  ants[ant].each_with_index do |coord1, index|
   ants[ant][(index + 1)..-1].each { |coord2| pp coord2; find_antipods(coord1, coord2)}
  end
end
# pp ants
# pp ants_num
$antipods.each do |line|
    pp line.join("")
    res += line.select {|c| c == "#"}.size
end

pp res