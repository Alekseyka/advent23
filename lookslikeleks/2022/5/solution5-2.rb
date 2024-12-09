#!/usr/bin/env ruby

require 'awesome_print'

result = ''
stacks = []
stacks_number = 9

File.foreach('input.txt') do |line|
  # Fill up the stacks
  if line.include?('[')
    stacks_number.times do |stack_index|
      stack_space = line[4 * stack_index, 3]
      stacks[stack_index] = stacks[stack_index].to_a.unshift stack_space.to_s[1] unless stack_space.to_s.strip.empty?
    end
  end

  if line.include?('move')
    scan = line.scan(/move (\d+) from (\d+) to (\d+)/)
    scan = scan[0].map(&:to_i)
    from = scan[1] - 1
    to = scan[2] - 1
    items = [stacks[from].pop(scan[0])].flatten
    stacks[to] += items
  end

end

puts "Result: '#{stacks.map { |s| s[-1] }.join('')}'"
