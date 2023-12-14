#!/usr/bin/env ruby

require 'awesome_print'

steps = 0
map = {}
lr = ''

File.foreach('input.txt').with_index do |line, index|
  (lr = line.sub(/\n/, '')) and next if index.zero?

  next if index == 1

  scan = line.scan(/(\w+) = \((\w+), (\w+)\)/)[0]
  map[scan[0]] = { 'L': scan[1], 'R': scan[2] }
end

lr_len = lr.length
initial_steps = map.keys.select { |i| i[2] == 'A' }
current_steps = initial_steps.dup
founds = []

initial_steps.each do |step|
  index = 0
  steps = 0
  while step[2] != 'Z'
    turn = lr[index]
    step = map[step][turn.to_sym]
    index = index + 1 > (lr_len - 1) ? 0 : index + 1
    steps += 1
  end
  ap step
  ap steps
  founds << steps
end

the_number = founds.inject(:*)
the_number2 = founds.inject(:lcm)
puts "The number: #{the_number2}, digits: #{the_number2.to_s.length}"

# lr_index = 0
# steps = 0
# while true
#   print "Steps: #{steps}. Length: #{steps.to_s.length}\r"
#   $stdout.flush
#   turn = lr[lr_index]
#   current_steps = current_steps.map { |i| map[i][turn.to_sym] }
#
#   # ap current_steps
#   # puts "ENDS? #{current_steps.select { |i| i[2] == 'Z' }}"
#   # break if current_steps.select { |i| i[2] == 'Z' }.length > 0
#   # break if steps > 19632
#
#   if current_steps.select { |i| i[2] == 'Z' }.length == current_steps.length
#     puts "\n"
#     ap current_steps
#     puts "STEPS #{steps + day01}"
#     break
#   else
#     lr_index = lr_index + day01 > (lr.length - day01) ? 0 : lr_index + day01
#     steps += day01
#   end
# end

