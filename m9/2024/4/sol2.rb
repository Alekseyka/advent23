#!/usr/bin/env ruby

require_relative '../common'
$get.day(4)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

matrix = input.each_line.map(&:strip).map {_1.split('').to_a}
counter = 0

matrix.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    begin
      counter +=1 if matrix[i][j] == 'M' && matrix[i][j+2] == 'S' && matrix[i+1][j+1] == 'A' && matrix[i+2][j] == 'M' && matrix[i+2][j+2] == 'S'
      counter +=1 if matrix[i][j] == 'S' && matrix[i][j+2] == 'M' && matrix[i+1][j+1] == 'A' && matrix[i+2][j] == 'S' && matrix[i+2][j+2] == 'M'
      counter +=1 if matrix[i][j] == 'M' && matrix[i][j+2] == 'M' && matrix[i+1][j+1] == 'A' && matrix[i+2][j] == 'S' && matrix[i+2][j+2] == 'S'
      counter +=1 if matrix[i][j] == 'S' && matrix[i][j+2] == 'S' && matrix[i+1][j+1] == 'A' && matrix[i+2][j] == 'M' && matrix[i+2][j+2] == 'M'
    rescue Exception => exception
      puts exception
    end
  end
end

ap counter


# input.scan(/mul\((\d+),(\d+)\)/).map { _1.map(&:to_i) }
#      .map { _1.first * _1.last }
#      .sum
#      .tap {ap _1}