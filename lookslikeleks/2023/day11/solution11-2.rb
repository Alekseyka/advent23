#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'
@space = []
@stretched_rows = []
@stretched_cols = []

def print_space(space)
  space.each { |i| puts i.join }
end

File.foreach(filename).with_index do |line, row_index|
  @space.push(line.sub(/\n/, '').chars)
  @stretched_rows.push(row_index) unless line.include?('#')
end

@space[0].each.with_index do |_col, col_index|
  @stretched_cols.push(col_index) unless @space.map { |row| row[col_index] }.include?('#')
end

print_space @space
ap @stretched_cols
ap @stretched_rows

@galaxies = []

@space.each.with_index do |row, row_index|
  row.each.with_index do |char, col_index|
    @galaxies.push([row_index, col_index]) if char == '#'
  end
end

result = 0
counted_galaxies = []
stretch_modifier = 1000000

@galaxies.each.with_index do |galaxy1, index1|
  puts "ind1: #{index1}"
  @galaxies.each.with_index do |galaxy2, index2|
    next if index1 == index2
    next if counted_galaxies.include?([index1, index2].sort.join(':'))

    row_diff = (galaxy1[0] - galaxy2[0]).abs
    col_diff = (galaxy1[1] - galaxy2[1]).abs
    empty_rows = @stretched_rows.select do |row|
      row > [galaxy1[0], galaxy2[0]].min &&
        row < [galaxy1[0], galaxy2[0]].max
    end.length
    row_modifier = empty_rows * stretch_modifier - empty_rows
    empty_colls = @stretched_cols.select do |col|
      col > [galaxy1[1], galaxy2[1]].min &&
        col < [galaxy1[1], galaxy2[1]].max
    end.length
    col_modifier = empty_colls * stretch_modifier - empty_colls
    result += row_diff + col_diff + row_modifier + col_modifier
    # puts "galaxy1: #{galaxy1}, galaxy2: #{galaxy2}, cm: #{col_modifier}, rm: #{row_modifier}, result: #{result}"
    counted_galaxies.push([index1, index2].sort.join(':'))
  end
end

puts "Result: #{result}"
