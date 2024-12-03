
pattern = /(mul\(\d{1,3}+,\d{1,3}\))/
res = 0

f = File.read('input3.txt')

matches = f.scan(pattern)

matches.each do |match_arr|
  match = match_arr[0]
  pos_1 = match.index("(")
  
  pos_2 = match.index(",")
  pos_3 = match.index(")")

  next unless (pos_1 + 1 <= pos_2 - 1) && (pos_2 + 1 <= pos_3 - 1)
  first_num = match[(pos_1 + 1)..(pos_2 - 1)].to_i
  second_num = match[(pos_2 + 1)..(pos_3 - 1)].to_i
  res += first_num * second_num if first_num <= 1000 && first_num > -1 && second_num <= 1000 && second_num > -1
end

pp res




