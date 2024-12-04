def find_xmas2(puzzle, pos_x, pos_y)
    return 1 if puzzle[pos_x][pos_y] == 'M' && puzzle[pos_x + 2][pos_y] == 'M' && puzzle[pos_x][pos_y + 2] == 'S' && puzzle[pos_x + 1][pos_y + 1] == 'A' && puzzle[pos_x + 2][pos_y + 2] == 'S' 
    return 1 if puzzle[pos_x][pos_y] == 'S' && puzzle[pos_x + 2][pos_y] == 'M' && puzzle[pos_x][pos_y + 2] == 'S' && puzzle[pos_x + 1][pos_y + 1] == 'A' && puzzle[pos_x + 2][pos_y + 2] == 'M' 
    return 1 if puzzle[pos_x][pos_y] == 'S' && puzzle[pos_x + 2][pos_y] == 'S' && puzzle[pos_x][pos_y + 2] == 'M' && puzzle[pos_x + 1][pos_y + 1] == 'A' && puzzle[pos_x + 2][pos_y + 2] == 'M' 
    return 1 if puzzle[pos_x][pos_y] == 'M' && puzzle[pos_x + 2][pos_y] == 'S' && puzzle[pos_x][pos_y + 2] == 'M' && puzzle[pos_x + 1][pos_y + 1] == 'A' && puzzle[pos_x + 2][pos_y + 2] == 'S' 
    return 0 

end

def count_xmas2(puzzle)
    res = 0
    puzzle.each_with_index do |line, index|
        line.each_with_index do |char, yindex|
            res += find_xmas2(puzzle, index, yindex)
        end
    end
    
    return res
end

puzzle = []
File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
      puzzle << (line.delete("\n").chars + ["q","q"])
    end
end
puzzle.push(Array.new(puzzle[0].size, "q"))
puzzle.push(Array.new(puzzle[0].size, "q"))


ans = 0

pp count_xmas2(puzzle)



