#!/usr/bin/env ruby

require 'awesome_print'
filename = 'input.txt'
# filename = 'example.txt'

result = 0

def ap_arr(arr)
  arr.each { |i| puts i.join(' ') }
end

File.foreach(filename) do |line|
  line_arr = []
  line_arr[0] = line.scan(/-?\d+/).map(&:to_i)

  index = 0
  loop do
    line_arr[index + 1] = line_arr[index]
                            .map.with_index { |x, i| line_arr[index][i + 1].nil? ? nil : line_arr[index][i + 1] - x }
                            .reject(&:nil?)
    index += 1

    break if line_arr[index].uniq.length == 1
  end

  index_r = line_arr.length - 1

  while index_r >= 0
    if line_arr[index_r].uniq.length == 1
      line_arr[index_r].push(line_arr[index_r][-1])
    else
      line_arr[index_r].push(line_arr[index_r][-1] + line_arr[index_r + 1][-1])
    end

    result += line_arr[index_r][-1] if index_r.zero?

    index_r -= 1
  end
end

puts "Result: '#{result}'"
