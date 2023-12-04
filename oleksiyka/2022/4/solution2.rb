require 'awesome_print'

sum = 0
a = false

File.foreach('input.txt') do |line|
  line = line.sub(/\n/, '')
  scan = line.scan(/^(\d+)-(\d+),(\d+)-(\d+)$/)[0].map(&:to_i)
  range1 = (scan[0]..scan[1]).to_a
  range2 = (scan[2]..scan[3]).to_a
  sum += 1 if range1.intersect?(range2) || range2.intersect?(range1)
end

p sum
