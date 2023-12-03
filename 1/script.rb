sum = 0
map = {
  'zero': 0,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
}
list = map.keys.map(&:to_s) + map.values.map(&:to_s)
puts list
rlist = list.map &:reverse

File.foreach("input.txt") do |line|
  first = line[Regexp.union(list)]
  first_n = first =~ /[0-9]/ ? first : map[first.to_sym]
  first_n = first_n.to_i  

  last = line.reverse[Regexp.union(rlist)]
  last_n = last =~ /[0-9]/ ? last : map[last.reverse.to_sym]
  last_n = last_n.to_i

  number = first_n*10+last_n
  sum+=number
end
puts sum
