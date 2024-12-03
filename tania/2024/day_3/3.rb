$donts = 0

def mult(match)
  pos_1 = match.index("(")
  
  pos_2 = match.index(",")
  pos_3 = match.index(")")

  return 0 unless (pos_1 + 1 <= pos_2 - 1) && (pos_2 + 1 <= pos_3 - 1)
  first_num = match[(pos_1 + 1)..(pos_2 - 1)].to_i
  second_num = match[(pos_2 + 1)..(pos_3 - 1)].to_i

  first_num * second_num 
end
 

pattern = /((mul\(\d{1,3}+,\d{1,3}\))|(don't\(\))|(do\(\)))/
res = 0
flip = true

f = File.read('input.txt')

matches = f.scan(pattern)

matches.each do |match_arr|
  match = match_arr[0]
  
  if match == "don't()"
    flip = false
    next
  end

  if match == "do()"
    flip = true
    next
  end

  next if flip == false

  res += mult(match) 
end

pp res




