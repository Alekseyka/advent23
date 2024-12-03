#!/usr/bin/env ruby

require_relative '../common'
$get.day(3)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

muls = [] 
dos = []
donts = []
result = []

input.scan(/mul\((\d+),(\d+)\)/) do |c|
  muls << [c.map(&:to_i), $~.offset(0)[0]]
end

input.scan(/do\(\)/) do |c|
  dos << [true, $~.offset(0)[0]]
end

input.scan(/don't\(\)/) do |c|
  donts << [false, $~.offset(0)[0]]
end


ary = (muls + dos + donts).sort_by { |e| e[1] }

flipper = true

ary.each_with_index do |e, index|
  if [ true, false ].include?(e[0])
    flipper = e[0]
  else
    result << e[0] if flipper
  end
end

result.map { _1.first * _1.last }
      .sum
      .tap {ap _1}

