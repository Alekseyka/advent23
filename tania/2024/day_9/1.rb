res = 0
disk2 = []
disk = ''

File.open('input3.txt', 'r') do |file|
    file.each_line do |line|
        disk = line.strip
    end
end

cur_num = 0
cur_sym = "num"
disk.chars.each do |c|
    # cur_num = cur_num % 10
  if cur_sym == "num"
    cur_sym = "dot"
    disk2 << Array.new(c.to_i, cur_num)
    cur_num += 1 unless c == '0'
  else 
    cur_sym = "num"
    disk2 << Array.new(c.to_i, '.')
  end
end

disk2.flatten!

l = 0 
r = disk2.size - 1

while (l < r) do 

    if disk2[l] == '.' && disk2[r] != '.'
        tmp = disk2[l]
        disk2[l] = disk2[r]
        disk2[r] = tmp
    elsif disk2[l] != '.'
        l += 1
    elsif disk2[r] == '.'
        r -= 1
    end
end

disk2.each_with_index do |c, i|
    break if c == '.'
    res += i * c 
end
# pp disk2
pp res