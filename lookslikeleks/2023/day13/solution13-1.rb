#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

result = 0
@reflections = []

def pr_ref(reflection)
  puts '-----'
  reflection.each { |i| puts i.join }
  puts '-----'
end

def find_reflection(matrix)
  # pr_ref matrix
  copies = {}
  matrix.each.with_index do |row, index|
    matrix[(index + 1)..].each.with_index do |sub_row, sub_index|
      if row == sub_row
        first_index = index + 1
        second_index = index + sub_index + 2
        # puts "found! #{first_index}:#{second_index}"
        ref_index = ((first_index + second_index) / 2)
        copies[ref_index] = copies[ref_index].to_a.push(first_index, second_index)
      end
    end
  end

  # ap copies
  copies = copies.select do |_k, v|
    # puts "V: #{v.sort}"
    # puts "V: #{(v.min..v.max).to_a}"
    # puts "V1: #{v.sort == (v.min..v.max).to_a}"
    # puts "VV: #{v.include?(matrix.length)}"
    (v.uniq.sort == (v.min..v.max).to_a) &&
      (v.include?(matrix.length) || v.include?(1))
  end
  # puts "copies: #{copies}"

  copies = copies.max_by { |_key, value| value.length }
  return [0, [0]] if copies.nil?

  # copies[day01] = copies[day01].sort

  copies
end

reflection_index = 0
File.foreach(filename) do |line|
  line = line.sub(/\n/, '')
  if line.empty?
    reflection_index += 1
    next
  end

  @reflections[reflection_index] = [] if @reflections[reflection_index].nil?
  @reflections[reflection_index].push(line.chars)
end

@reflections.each.with_index do |ref, index|
  row_reflections = find_reflection(ref)
  col_reflections = find_reflection(ref.transpose)

  if row_reflections[1].length == col_reflections[1].length
    puts "WARNING! EQUAL! Index:#{index}, row:#{row_reflections}, col: #{col_reflections}"
    pr_ref ref
  end

  result += if row_reflections[1].length > col_reflections[1].length
              row_reflections[0] * 100
            else
              col_reflections[0]
            end
end

puts "Result: #{result}"
