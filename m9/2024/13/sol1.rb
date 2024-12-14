#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# rubocop:disable Style/GlobalVars
$get.day(13)
input = File.read($o[:test] ? 'example.txt' : 'input.txt').each_line.map(&:strip)
input << ''
# rubocop:enable Style/GlobalVars

cursor = 0
data = []

while cursor < input.size
  data << {
    a: input[cursor].match(/.*X\+(\d+), Y\+(\d+).*/)[1..2].map(&:to_i),
    b: input[cursor + 1].match(/.*X\+(\d+), Y\+(\d+).*/)[1..2].map(&:to_i),
    p: input[cursor + 2].match(/.*X=(\d+), Y=(\d+).*/)[1..2].map(&:to_i)
  }
  cursor += 4
end

# def gcd(val_a, val_b)
#   val_b.zero? ? val_a : gcd(val_b, val_a % val_b)
# end

# def lcm(val_a, val_b)
#   val_a * val_b / gcd(val_a, val_b)
# end

# binding.pry

res = []

(1..100).each do |i|
  (1..100).each do |j|
    data.each do |d|
      res << [i, j] if d[:a][0] * i + d[:b][0] * j == d[:p][0] && d[:a][1] * i + d[:b][1] * j == d[:p][1]
    end
  end
end

pp(res.sum { |r| r[0] * 3 + r[1] })
