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

def donts_and_dos(before_match)
  return false if before_match.nil? || before_match.size < 4
  return true if before_match.include?("do()") && !before_match.include?("don't()")
  if before_match.include?("don't()")
    $donts = 1
    pos = before_match.index("don't()") 
    false || donts_and_dos(before_match[pos+7..-1])
  end
  return true if $donts == 0 
  return false if $donts == 1
end  

pattern = /(mul\(\d{1,3}+,\d{1,3}\))/
res = 0

f = File.read('input3.txt')
f_left = f


matches = f.scan(pattern)

matches.each do |match_arr|
  match = match_arr[0]
  
  pp match 
  pp f_left
  pos = f_left.index(match)
  pp pos
  if pos < 4 && $donts == 1
    f_left = f_left[(pos + match.size)..-1]  
    res += mult(match)
    next
  end

  before_match = f_left[0..(pos - 1)]
  pp "before match #{before_match}"
  if donts_and_dos(before_match) == true
    res += mult(match)
  end
  f_left = f_left[(pos + match.size)..-1]  
  pp f_left
end

pp res




