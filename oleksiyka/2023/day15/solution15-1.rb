#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

do_hash = lambda do |str|
  sum = 0
  str.chars.each do |char|
    sum += char.ord
    sum *= 17
    sum %= 256
  end
  sum
end

@sequence = File.read(filename).sub(/\n/, '').split(',')

puts @sequence.map { |str| do_hash.call(str) }.sum
