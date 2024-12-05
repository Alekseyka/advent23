def reorder(rules, input)
    printed = []
    input.each_with_index do |print, index|
        printed << print
        next if index == 0

        printed1 = printed

        if !rules[print].nil? && printed.intersect?(rules[print])
            printed = printed - printed.intersection(rules[print]) + reorder(rules, printed.intersection(rules[print]))
        end
    end 

    return printed 
end

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
            if index == 0
                printed << print
                next 
            end
            printed << print

            if !rules[print].nil? && printed.intersect?(rules[print])
                valid = false 
                break  
            end
        end
        if valid == false 
            new_order = reorder(rules, input)
            res += new_order[input.size / 2] 
        end
      end
    end
end

pp res