#!/usr/bin/env ruby

# Card day01: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
# Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
# Card 3:  day01 21 53 59 44 | 69 82 63 72 16 21 14  day01
# Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
# Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
# Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11


require 'pry'
require 'awesome_print'
require_relative '../lib/advent_of_code_client.rb'

if File.zero? 'input.txt'
  File.write 'input.txt', AdventOfCodeClient.new.get_task_input('4')
end

input = File.read('input.txt')

input.each_line.sum do |line|
  _, ls, rs = line.split(/[|:]/)

  l = ls.scan(/\d+/)
  r = rs.scan(/\d+/)

  m = (f.intersection(l)).count

  m > 0 ? 2**(m - 1) : 0
end.tap {puts _1.to_i }

