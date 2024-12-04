def find_all_xmas(puzzle, pos_x, pos_y)
    res = 0
    if pos_y + 3 <= puzzle[pos_x].length - 1 
      res += 1 if puzzle[pos_x][pos_y..(pos_y+3)].join('') == "XMAS"
    end    
    if pos_y - 3 >= 0
      res += 1 if puzzle[pos_x][(pos_y-3)..pos_y].join('').reverse == "XMAS" 
    end
    if pos_x + 3 <= puzzle.size - 1 
        word = puzzle[pos_x][pos_y] + puzzle[pos_x + 1][pos_y] + puzzle[pos_x + 2][pos_y] + puzzle[pos_x + 3][pos_y]
        res += 1 if word == "XMAS"
    end
    if pos_x - 3 >= 0
        word = puzzle[pos_x][pos_y] + puzzle[pos_x - 1][pos_y] + puzzle[pos_x - 2][pos_y] + puzzle[pos_x - 3][pos_y]
        res += 1 if word == "XMAS"
    end
    if pos_y + 3 <= puzzle[pos_x].length - 1 && pos_x + 3 <= puzzle.size - 1 
        word = puzzle[pos_x][pos_y] + puzzle[pos_x + 1][pos_y + 1] + puzzle[pos_x + 2][pos_y + 2] + puzzle[pos_x + 3][pos_y + 3] 
        res += 1 if word == "XMAS" 
    end  
    if pos_y + 3 <= puzzle[pos_x].length - 1 && pos_x - 3 >= 0
        word = puzzle[pos_x][pos_y] + puzzle[pos_x - 1][pos_y + 1] + puzzle[pos_x - 2][pos_y + 2] + puzzle[pos_x - 3][pos_y + 3] 
        res += 1 if word == "XMAS" 
    end  
    if pos_y - 3 >= 0 && pos_x + 3 <= puzzle.size - 1 
        word = puzzle[pos_x][pos_y] + puzzle[pos_x + 1][pos_y - 1] + puzzle[pos_x + 2][pos_y - 2] + puzzle[pos_x + 3][pos_y - 3] 
        res += 1 if word == "XMAS" 
    end  
    if pos_y - 3 >= 0 && pos_x - 3 >= 0
        word = puzzle[pos_x][pos_y] + puzzle[pos_x - 1][pos_y - 1] + puzzle[pos_x - 2][pos_y - 2] + puzzle[pos_x - 3][pos_y - 3] 
        res += 1 if word == "XMAS" 
    end    

    return res
end

puzzle = []
File.open('input.txt', 'r') do |file|
    file.each_line do |line|
      puzzle << line.chars[0..-2]
    end
end
pp puzzle

ans = 0

puzzle.each_with_index do |line, index|
    line.each_with_index do |char, yindex|
        
        if char == 'X'
            pp "x: #{index}, y :#{yindex}"
            ans += find_all_xmas(puzzle, index, yindex)
            pp find_all_xmas(puzzle, index, yindex)
        end    
    end
end

pp ans



