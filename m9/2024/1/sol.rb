FNAME = 'input.txt'
# FNAME = 'example.txt'

file_data = nil

File.open(FNAME, 'r') do |f|
  file_data = f.each_line.map {|l| l.match(/(\d+)\s+(\d+)/).captures}
end

file_data = file_data.to_a.map {|a| a.map &:to_i}

arr_l =(file_data.map &:first).sort
arr_r =(file_data.map &:last).sort

arr_sol_1 = [arr_l, arr_r].transpose.map { |x| x.reduce &:- }.map(&:abs).reduce &:+
arr_sol_2 = arr_l.map {|x| x*arr_r.count(x)}.reduce &:+

pp arr_sol_1
pp arr_sol_2
