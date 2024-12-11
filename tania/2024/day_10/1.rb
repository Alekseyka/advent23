top_map = []

def find_trail(top_map, pos_x, pos_y, num)
    return 0 if pos_x < 0 || pos_y < 0 || pos_x >= top_map[0].size || pos_y >= top_map.size
    return 1 if top_map[pos_y][pos_x] == 9 && num == 9
    # pp "y #{pos_y} x #{pos_x} cur_val #{num}"
    res = 0
    res += find_trail(top_map, pos_x + 1, pos_y, num + 1) if pos_x + 1 < top_map[0].size && top_map[pos_y][pos_x + 1] == num + 1
    res += find_trail(top_map, pos_x - 1, pos_y, num + 1) if pos_x - 1 >= 0 && top_map[pos_y][pos_x - 1] == num + 1
    res += find_trail(top_map, pos_x, pos_y + 1, num + 1) if pos_y + 1 < top_map.size && top_map[pos_y + 1][pos_x] == num + 1
    res += find_trail(top_map, pos_x, pos_y - 1, num + 1) if pos_y - 1 >= 0 && top_map[pos_y - 1][pos_x] == num + 1
    # pp "y #{pos_y} x #{pos_x} cur_val #{num} res #{res}"
    return res
end

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
        top_map << line.strip.chars.map {|c| c.to_i}
    end
end

ans = 0
top_map.each_with_index do |line, y_in|
    line.each_with_index do |c, x_in|
        if c == 0
            pp find_trail(top_map, x_in, y_in, 0)
            ans += find_trail(top_map, x_in, y_in, 0)
        end
    end
end

pp ans