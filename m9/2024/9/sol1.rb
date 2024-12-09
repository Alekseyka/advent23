#!/usr/bin/env ruby

require_relative '../common'
require 'pry'
require 'matrix'

$get.day(9)

input = File.read($o[:test] ? 'example.txt' : 'input.txt').strip.split('').map(&:to_i)
files = []
free_space = []
full_disk = []

files = input.each.with_index.select {|_, idx| idx % 2 == 0 }.map(&:first)
free_space = input.each.with_index.select {|_, idx| idx % 2 != 0 }.map(&:first)
current_file = 0

files.each.with_index do |file, idx|
  # next if idx == files.size - 1
  free_space_count = free_space[idx] || 0
  file.times { full_disk << current_file }
  free_space_count.times { full_disk << '.' }
  current_file += 1
end

empty_indexes = full_disk.each.with_index.select {|el, _| el == '.' }.map(&:last)

pp input
pp files
pp free_space
pp full_disk.join("")
pp empty_indexes

new_disk = full_disk.clone

l = 0
r = full_disk.length - 1

while full_disk.length - r >= 0 do
  break if empty_indexes[l].nil?
  index = empty_indexes[l]
  puts "l=#{l}, r=#{r}, index=#{index}, full_disk[r]=#{full_disk[r]}"
  if full_disk[r] == '.'
    r -= 1
    next
  else
    new_disk[index] = full_disk[r]
    # new_disk[r] = '_'
    r -= 1
    l += 1
  end
end

pp new_disk.size
pp l 

new_disk.pop(l)

sum = 0

new_disk.each.with_index do |el, idx|
  sum += el * idx
end

puts sum

# pp (new_disk + Array.new(l, '.')).join('')
# pp new_disk.join("")