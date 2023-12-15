#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

@boxes = {}
@focal_length = {}

do_hash = lambda do |str|
  sum = 0
  str.chars.each do |char|
    sum += char.ord
    sum *= 17
    sum %= 256
  end
  sum
end

process_lense = lambda do |lense|
  box_id = do_hash.call(lense[0])
  @boxes[box_id] = [] if @boxes[box_id].nil?
  if lense[1] == '-'
    @boxes[box_id].delete(lense[0])
  else
    @focal_length[lense[0]] = lense[2].to_i
    @boxes[box_id].push(lense[0]) unless @boxes[box_id].include?(lense[0])
  end
end

@sequence = File.read(filename).sub(/\n/, '').split(',').map { |str| str.scan(/(\w*)([-=])(\d?)/)[0] }

@sequence.each { |step| process_lense.call(step) }

puts(@boxes.map { |k, box| box.map.with_index { |lense, j| (k + 1) * (j + 1) * (@focal_length[lense]) }.sum }.sum)
# puts @sequence.map { |str| do_hash.call(str) }.sum
