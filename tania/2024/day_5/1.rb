pages = true
rules = {}
res = 0

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
      if line == "\n"
        pages = false
        next
      end

      if pages == true 
        a,b = line.delete("\n").split("|").map { |s| s.to_i}
        if rules[a].nil? 
            rules[a] = [b]
        else 
            rules[a].push(b)
        end 
      end
      
      if pages == false 
        input = line.delete("\n").split(",").map { |s| s.to_i }

        printed = []
        valid = true
        input.each_with_index do |print, index|
            printed << print
            next if index == 0

            if !rules[print].nil? && printed.intersect?(rules[print])
                valid = false 
                break  
            end
        end
        res += input[input.size / 2] if valid == true
      end
    end
end

pp res