#!/usr/bin/env ruby

require 'awesome_print'

# filename = 'input.txt'
filename = 'example.txt'

ref_diff = ->(ref, i) { ref.map { |l| l[i..].zip(l[0..(i - 1)].reverse).map { |pair| pair[0] == pair[1] ? 0 : 1 }.sum }.sum }
reflections = ->(ref, d) { (1..ref[0].length).map { |j| ref_diff.call(ref, j) == d ? j : 0 }.sum }

@reflections = []
File.read(filename).split("\n\n").each.with_index { |ref, index| @reflections[index] = ref.split("\n").map(&:chars) }

result = 0
@reflections.each { |ref| result += reflections.call(ref.transpose, 1) + 100 * reflections.call(ref, 1) }

puts "Result: #{result}"
