#!/usr/bin/env ruby

require_relative '../common'
$get.day(2)

input     = File.read($o[:test] ? 'example.txt' : 'input.txt')
input.each_line
     .map {
       _1.split.map(&:to_i)
     }
     .map {
       _1 if ((_1 == _1.sort) || (_1 == _1.sort.reverse)) && (_1 == _1.uniq)
     }
     .compact
     .map {
       _1.each_cons(2).map { |a, b| (a - b).abs }.max
     }
     .map {_1 <= 3 || nil}
     .compact.length
     .tap {ap _1}
