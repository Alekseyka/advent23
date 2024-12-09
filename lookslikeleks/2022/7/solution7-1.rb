#!/usr/bin/env ruby

require 'awesome_print'

WINDOW_LENGTH = 4

buffer = File.read('input.txt')
l = buffer.length
i = 0
result = 0

while i < l - WINDOW_LENGTH
  window = buffer[i, WINDOW_LENGTH].to_s
  (p window) and (result = i + WINDOW_LENGTH) and break if window.split('').uniq.join('') == window

  i += 1
end

puts "Result: '#{result}'"
