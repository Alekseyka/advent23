a1 = []
a2 = []

File.foreach('in.txt') do |line|
  number1, number2 = line.split.map(&:to_i)

  a1.push(number1)
  a2.push(number2)
end

a1 = a1.sort
a2 = a2.sort

s1 = 0
s2 = 0

a1.each.with_index do |number1, i|
  s1 += (number1 - a2[i]).abs
  s2 += number1 * a2.count(number1)
end

p s1
p s2