list1 = []
list2 = []

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
        list1 << line.split("   ")[0].to_i
        list2 << line.split("   ")[1].to_i
      end
end

list1.sort!
list2.sort!
res = 0

list1.each_with_index do |el, index|
  res += (el - list2[index]).abs
end 

puts res