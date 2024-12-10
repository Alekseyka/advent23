#!/usr/bin/env ruby

require_relative '../common'

$get.day(11)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

input.each_line do |line|
  map << line.strip.split('')
end

