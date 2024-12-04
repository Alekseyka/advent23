#!/usr/bin/env ruby

require_relative '../common'
$get.day(4)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

m = input.each_line.map(&:strip).map {_1.split('').to_a}
res = 0

m.each_with_index do |r, i|
  r.each_with_index do |c, j|
    begin
      res +=1 if m[i][j] == 'M' && m[i][j+2] == 'S' && m[i+1][j+1] == 'A' && m[i+2][j] == 'M' && m[i+2][j+2] == 'S'
      res +=1 if m[i][j] == 'S' && m[i][j+2] == 'M' && m[i+1][j+1] == 'A' && m[i+2][j] == 'S' && m[i+2][j+2] == 'M'
      res +=1 if m[i][j] == 'M' && m[i][j+2] == 'M' && m[i+1][j+1] == 'A' && m[i+2][j] == 'S' && m[i+2][j+2] == 'S'
      res +=1 if m[i][j] == 'S' && m[i][j+2] == 'S' && m[i+1][j+1] == 'A' && m[i+2][j] == 'M' && m[i+2][j+2] == 'M'
    rescue Exception => e
      # puts e
    end
  end
end

ap res
