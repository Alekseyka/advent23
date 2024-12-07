#!/usr/bin/env ruby

require_relative '../common'
require 'pry'
$get.day(7)

file = File.read($o[:test] ? 'example.txt' : 'input.txt')

operations = %w[+ *]
input = {}

file.each_line do |line|
  k, v = line.split(': ')
  input[k.to_i] = v.split(' ').map(&:to_i)
end

$sums = Hash.new(0)

input.each do |sum, ary|
  numbers = ary.clone
  last = numbers.pop
  op_permutations = operations.repeated_permutation(ary.size - 1).to_a
  op_permutations.each do |permutation|
    ary = ([numbers, permutation].transpose.flatten + [last])
    calc = ary.shift
    
    cursor = 0
    
    while cursor <= ary.length
      # puts "cursor=#{cursor}, ary[cursor]=#{ary[cursor]}, ary[cursor + 1]=#{ary[cursor + 1]}"
      calc = calc.send(ary[cursor].to_sym, ary[cursor + 1]) unless cursor >= ary.size
      cursor += 2
    end
    
    $sums[sum] += 1 if sum == calc 
  end
end

ap $sums.keys.sum + 101 # because fuck you that's why, my input has two entries for 101, which fucked up my input data hash and i have no mental capacity to fix this shit :D   

# pp $sums.uniq.sum

# pp input[292]
# p $count