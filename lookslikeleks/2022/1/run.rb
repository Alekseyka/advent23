require 'awesome_print'

elves = []
index = 0

File.foreach('in.txt') do |line|
  line = line.sub(/\n/, '')
  if line.empty?
    index += 1
    next
  end
  line = line.to_i
  elves[index] = elves[index].to_i + line.to_i
end

p elves.max
p elves.max(3).sum
