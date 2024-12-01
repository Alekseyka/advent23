list1 = []
list2 = {}

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
        char = line.split("   ")[1].to_i
        list1 << line.split("   ")[0].to_i
        unless list2[char].nil?
            list2[char] += 1
        else 
            list2[char] = 1
        end
      end
end

res = 0

list1.each do |el|
    next if list2[el].nil?
    res += el * list2[el]
end 

puts res