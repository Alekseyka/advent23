#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'
CYCLES = 1_000_000_000

def pr_pl(platform)
  platform.each { |i| puts i.join }
end

go_north = ->(p) { p.transpose.map { |l| l.join('').gsub(/[O.]+/) { |part| 'O' * part.count('O') + '.' * part.count('.') }.chars }.transpose }
calculate = ->(p) { p.map.with_index { |l, i| l.count('O') * (p.length - i) }.sum }
turn90 = ->(p) { p.transpose.map(&:reverse) }
cycle = lambda do |p|
  4.times do
    p = go_north.call(p)
    p = turn90.call(p)
  end
  p
end

@platform = File.read(filename).split("\n").map(&:chars)

@versions = {}

CYCLES.times do |i|
  c = i + 1
  print "#{c}\r"
  $stdout.flush
  @platform = cycle.call(@platform)
  pl_str = @platform.map { |l| l.join('&') }.join('&')
  if @versions.keys.include?(pl_str) && ((CYCLES - c) % (c - @versions[pl_str])).zero?
    puts "Result: #{calculate.call(@platform)}"
    break
  end
  @versions[pl_str] = c
end
