#!/usr/bin/env ruby

require_relative '../common'
require 'pry'
require 'matrix'

$get.day(8)

file = File.read($o[:test] ? 'example.txt' : 'input.txt')
input = []

antennas = {}

file.each_line do |line|
  input << line.strip.split('')
end

input.each_with_index do |line, x|
  line.each_with_index do |node, y|
    next if node == '.' || node == '#'
    antennas[node] = [] if antennas[node].nil?
    antennas[node].push([x, y]) 
  end
end

$max_x = input.size - 1
$max_y = input[0].size - 1

def check_bounds(p)
  p[0] >= 0 && p[1] >= 0 && p[0] <= $max_x && p[1] <= $max_y
end

def get_anti(a, b)
  va = Vector[a[0], a[1]]
  vb = Vector[b[0], b[1]]
  
  dist = vb - va
  
  nva = va + dist*2
  nvb = vb - dist*2
  
  res = []
  
  res << [nva[0], nva[1]] if check_bounds(nva)
  res << [nvb[0], nvb[1]] if check_bounds(nvb)
  
  res
end

antis = []

antennas.each do |k, v|
  v.combination(2).map(&:sort).uniq.each do |a, b|
    antis += get_anti(b, a)
  end
end

pp antis.uniq.count