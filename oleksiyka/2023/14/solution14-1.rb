#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

def pr_pl(platform)
  platform.each { |i| puts i.join }
end

go_north = ->(p) { p.transpose.map { |l| l.join('').gsub(/[O.]+/) { |part| 'O' * part.count('O') + '.' * part.count('.') }.chars }.transpose }
calculate = ->(p) { p.map.with_index { |l, i| l.count('O') * (p.length - i) }.sum }

@platform = []
@platform = File.read(filename).split("\n").map(&:chars)

# pr_pl @platform
pl_n = go_north.call(@platform)
puts calculate.call(pl_n)
