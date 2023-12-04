#!/usr/bin/env ruby

require 'awesome_print'

result = 0

File.foreach('input.txt') do |line|
  p '-----'
  scan = line.scan(/Card\s+\d+:((?:\s+\d+)+)\s\|((?:\s+\d+)+)/)[0]
  win_n = scan[0].strip.split(' ')
  cur_n = scan[1].strip.split(' ')
  win = win_n.intersection(cur_n)
  if win.length.positive?
    result += 2**(win.length - 1)
  end
end

puts "Result: '#{result}'"
