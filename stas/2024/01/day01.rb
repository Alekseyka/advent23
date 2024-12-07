arr_l = []
arr_r = []

File.readlines('input.txt', chomp: true).each do |line|
  values = line.split("   ")
  arr_l << values[0].to_i
  arr_r << values[1].to_i
end

arr_l.sort!
arr_r2 = arr_r.dup
arr_r.sort!.reverse!

distance = arr_l.map { |e| (e - arr_r.pop).abs }.inject(:+)

similarity = arr_l.map { |l| arr_r2.select { |r| l == r}.count * l }.inject(:+)

puts "distance: #{distance}"
puts "similarity: #{similarity}"