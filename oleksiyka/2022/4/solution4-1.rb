require 'awesome_print'

sum = 0

File.foreach('input.txt') do |line|
  line = line.sub(/\n/, '')
  scan = line.scan(/^(\d+)-(\d+),(\d+)-(\d+)$/)[0].map(&:to_i)
  range1 = ".#{(scan[0]..scan[1]).to_a.join('.')}."
  range2 = ".#{(scan[2]..scan[3]).to_a.join('.')}."
  sum += 1 if range1.include?(range2) || range2.include?(range1)
end

p sum
