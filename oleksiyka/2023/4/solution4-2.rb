#!/usr/bin/env ruby

require 'awesome_print'

copies = []
index = 0

File.foreach('input.txt') do |line|
  copies[index] = copies[index].to_i + 1
  scan = line.scan(/Card\s+\d+:((?:\s+\d+)+)\s\|((?:\s+\d+)+)/)[0]
  win_n = scan[0].strip.split(' ')
  cur_n = scan[1].strip.split(' ')
  win = win_n.intersection(cur_n)
  if win.length.positive?
    win.length.times.with_index do |i, j|
      copies[index + j + 1] = copies[index + j + 1].to_i + copies[index].to_i
    end
  end

  index += 1
end

ap copies
p copies.sum
