@stones = {}
@transformations = { 0 => 1 }

def blink
  @new_stones = {}
  @stones.each do |k, v|
    if k == 0
      @new_stones[1] = @new_stones[1].to_i + v
    elsif (Math.log10(k).to_i + 1).even?
      transformation = @transformations[k]
      if transformation
        @new_stones[transformation[0]] = @new_stones[transformation[0]].to_i + v
        @new_stones[transformation[1]] = @new_stones[transformation[1]].to_i + v
      else
        i = 10 ** ((Math.log10(k).to_i + 1) / 2)
        left_part = k / i
        right_part = k % i
        @transformations[k] = [left_part, right_part]
        @new_stones[left_part] = @new_stones[left_part].to_i + v
        @new_stones[right_part] = @new_stones[right_part].to_i + v
      end
    else
      transformation = @transformations[k]
      if transformation
        @new_stones[transformation] = @new_stones[transformation].to_i + v
      else
        new_k = k * 2024
        @transformations[k] = new_k
        @new_stones[new_k] = @new_stones[new_k].to_i + v
      end
    end
  end
  @stones = @new_stones
end

line = File.read('in.txt').sub("\n", '').split(' ').map(&:to_i)
line.each do |stone|
  @stones[stone] = 1
end

75.times do |i|
  blink
  p "#{i}: #{@stones.values.sum}"
end

p @stones.values.sum