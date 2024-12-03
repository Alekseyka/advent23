#!/usr/bin/env ruby

require_relative '../common'
$get.day(3)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')
input.scan(/mul\((\d+),(\d+)\)/).map { _1.map(&:to_i) }
     .map { _1.first * _1.last }
     .sum
     .tap {ap _1}