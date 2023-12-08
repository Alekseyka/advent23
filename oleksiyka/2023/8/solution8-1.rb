#!/usr/bin/env ruby

require 'awesome_print'

steps = 0
lr = ''
map = {}
current_step = 'AAA'

File.foreach('input.txt').with_index do |line, index|
  (lr = line.sub(/\n/, '')) and next if index.zero?

  next if index == 1

  scan = line.scan(/(\w+) = \((\w+), (\w+)\)/)[0]
  map[scan[0]] = {'L': scan[1], 'R': scan[2]}
end

lr_len = lr.length
index = 0

while current_step != 'ZZZ'
  turn = lr[index]
  current_step = map[current_step][turn.to_sym]
  index = index + 1 > (lr_len - 1) ? 0 : index + 1
  steps += 1
end

# ap lr_len
# ap lr
# ap map
# ap map['AAA']
puts "Result: '#{steps}'"
