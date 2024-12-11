def blink(line)
  new_line = line.dup
  index_shift = 0
  line.each.with_index do |stone, index|
    if stone == 0
      new_line[index + index_shift] = 1
      next
    end
    if stone.to_s.length.even?
      stone_str = stone.to_s
      middle = stone_str.length / 2
      first_half = stone_str[0...middle].to_i
      second_half = stone_str[middle..].to_i
      new_line[index + index_shift] = first_half
      new_line.insert(index + index_shift + 1, second_half)
      index_shift += 1
      next
    end
    new_line[index + index_shift] = stone * 2024
  end
  new_line
end

line = File.read('in.txt').sub("\n", '').split(' ').map(&:to_i)

25.times do |i|
  line = blink(line)
  p "#{i}: #{line.length}"
end

p line.length