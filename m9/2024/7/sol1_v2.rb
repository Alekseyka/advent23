#!/usr/bin/env ruby

require_relative '../common'
require 'pry'
$get.day(7)

file = File.read($o[:test] ? 'example.txt' : 'input.txt')

operations = %I[+ *]
input = []

file.each_line do |line|
  k, v = line.split(': ')
  input << [k.to_i, v.split(' ').map(&:to_i)]
end

$sums = Hash.new(0)
index = 0

input.each do |sum, ary|
  numbers = ary.clone
  last = numbers.pop
  op_permutations = operations.repeated_permutation(ary.size - 1).to_a
  
  op_permutations.each do |permutation|
    ary = ([numbers, permutation].transpose.flatten + [last])
    calc = ary[0]

    ary.each_with_index do |current, cursor|
      next if cursor == 0
      left = ary[cursor - 1]
      # puts "calc=#{calc}, left=#{left}, current=#{current}"
      calc = calc.send(left, current) if operations.include?(left)
    end
    
    $sums[index] = sum if sum == calc
  end
  
  index += 1
end

ap $sums.values.sum