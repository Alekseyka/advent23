#!/usr/bin/env ruby

require_relative '../common'
$get.day(3)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')
            .each_line
            .map { _1.split.map(&:to_i) }
ap input