def rules_match(arr)
  rules = []
  rules << (arr.uniq.count == arr.count)
  rules << (arr.sort == arr || arr.sort.reverse == arr)

  arr.sort!
  unsafe = []
  (arr.count - 1).times do 
    unsafe << (arr.pop - arr.last > 3)
  end
  rules << unsafe.none?
  rules.all?
end

def second_chance(arr)
  result = []
  arr.count.times do |i|
    array = arr.dup
    array.delete_at(i)
    result << rules_match(array)
  end
  result.any?
end

part1 = 0
part2 = 0
File.readlines('input.txt', chomp: true).each do |line|
  array = line.split.map &:to_i
  if rules_match(array.dup)
    part1 += 1
  else
    part2 += 1 if second_chance(array.dup)
  end
  
end

puts part1
puts part2
puts part1 + part2