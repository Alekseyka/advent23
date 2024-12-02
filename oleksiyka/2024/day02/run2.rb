q = 0

File.foreach('in.txt') do |line|
  line = line.gsub("\n", "").split(' ').map(&:to_i)

  sorted_inc = line.each_cons(2).all? { |a, b| a < b }
  sorted_dec = line.each_cons(2).all? { |a, b| a > b }

  diff = line.each_cons(2).all? { |a, b| (b - a).abs <= 3 }

  q += 1 and next if (sorted_dec || sorted_inc) && diff

  (0...line.size).each do |i|
    new_line = line[0...i] + line[(i + 1)..]

    sorted_inc = new_line.each_cons(2).all? { |a, b| a < b }
    sorted_dec = new_line.each_cons(2).all? { |a, b| a > b }

    diff = new_line.each_cons(2).all? { |a, b| (b - a).abs <= 3 }

    if (sorted_dec || sorted_inc) && diff
      q += 1
      break
    end
  end
end

p q