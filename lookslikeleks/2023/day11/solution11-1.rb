#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'
@space = []

def print_space(space)
  space.each { |i| puts i.join }
end

File.foreach(filename).with_index do |line, row|
  @space.push(line.sub(/\n/, '').chars)
  @space.push(line.sub(/\n/, '').chars) unless line.include?('#')
end

@new_space = []

@space[0].each.with_index do |_col, col_index|
  all_dot = true
  @space.each.with_index do |_row, row_index|
    all_dot = false if @space[row_index][col_index] == '#'
    if col_index.zero?
      @new_space[row_index] = [@space[row_index][col_index]]
    else
      @new_space[row_index].push(@space[row_index][col_index])
    end
  end
  if all_dot
    @space.each.with_index do |_row, row_index|
      @new_space[row_index].push(@space[row_index][col_index])
    end
  end
end

@galaxies = []

@new_space.each.with_index do |row, row_index|
  row.each.with_index do |char, col_index|
    puts "#{row_index}:#{col_index}" if char == '#'
    @galaxies.push([row_index, col_index]) if char == '#'
  end
end


result = 0
counted_galaxies = []

@galaxies.each.with_index do |galaxy1, index1|
  puts "FIRST #{index1}"
  @galaxies.each.with_index do |galaxy2, index2|
    next if index1 == index2
    next if counted_galaxies.include?([index1, index2].sort.join(':'))

    result += (galaxy1[0] - galaxy2[0]).abs + (galaxy1[1] - galaxy2[1]).abs
    counted_galaxies.push([index1, index2].sort.join(':'))
  end
end

puts "Result: #{result}"
