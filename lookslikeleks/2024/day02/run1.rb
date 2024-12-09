q = 0

File.foreach('in.txt') do |line|
  line = line.gsub("\n", "").split(' ').map(&:to_i)

  sorted_inc = line.each_cons(2).all? { |a, b| a < b }
  sorted_dec = line.each_cons(2).all? { |a, b| a > b }

  diff = line.each_cons(2).all? { |a, b| (b - a).abs <= 3 }

  q += 1 if (sorted_dec || sorted_inc) && diff
end

p q