#!/usr/bin/env ruby

require 'pry'
require 'awesome_print'

input = File.read('example.txt')
# input = File.read('input.txt')

input
  .each_line
# .sum {_1.to_i }
# .map(&:to_i)
# .inject(:*)
# .tap { ap _1  }