#!/usr/bin/env ruby

require 'pry'
require 'awesome_print'
require_relative '../lib/advent_of_code_client.rb'

if File.zero? 'input.txt'
  File.write 'input.txt', AdventOfCodeClient.new.get_task_input('7')
end

# input = File.read('input.txt')
input = File.read('example.txt')

input
  .each_line
# .sum {_1.to_i }
# .map(&:to_i)
# .inject(:*)
# .tap { ap _1  }
