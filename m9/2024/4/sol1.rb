#!/usr/bin/env ruby

require_relative '../common'
$get.day(4)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

m = input.each_line.map(&:strip).map {_1.split('').to_a}
res = 0

m.each_with_index do |r, i|
  r.each_with_index do |c, j|
    begin
      res += 1 if m[i][j] == 'X' && m[i][j+1] == 'M' && m[i][j+2] == 'A' && m[i][j+3] == 'S'
      res += 1 if m[i][j] == 'X' && m[i+1][j] == 'M' && m[i+2][j] == 'A' && m[i+3][j] == 'S'
      res += 1 if m[i][j] == 'S' && m[i][j+1] == 'A' && m[i][j+2] == 'M' && m[i][j+3] == 'X'
      res += 1 if m[i][j] == 'S' && m[i+1][j] == 'A' && m[i+2][j] == 'M' && m[i+3][j] == 'X'

      res += 1 if m[i][j] == 'X' && m[i+1][j+1] == 'M' && m[i+2][j+2] == 'A' && m[i+3][j+3] == 'S'
      res += 1 if m[i][j] == 'S' && m[i+1][j+1] == 'A' && m[i+2][j+2] == 'M' && m[i+3][j+3] == 'X'
      res += 1 if m[i][j+3] == 'X' && m[i+1][j+2] == 'M' && m[i+2][j+1] == 'A' && m[i+3][j] == 'S'
      res += 1 if m[i][j+3] == 'S' && m[i+1][j+2] == 'A' && m[i+2][j+1] == 'M' && m[i+3][j] == 'X'
    rescue Exception => e
      # puts e
    end
  end
end

ap res
