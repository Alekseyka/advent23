require 'pry'

class String
  def numeric?
    self =~ /[0-9]/
  end

  def to_numeric
    h = {
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
    h[self.to_sym]
  end
end

def cn(line)
  list = %w{0 1 2 3 4 5 6 7 8 9 zero one two three four five six seven eight nine}
  rlist = list.map &:reverse
  fline = line[Regexp.union(list)]
  rline = line.reverse[Regexp.union(rlist)]
  f = fline.numeric? ? fline.to_i : fline.to_numeric
  r = rline.numeric? ? rline.to_i : rline.reverse.to_numeric
  10*f.to_i + r.to_i
end

tmp = []
File.open('input.txt', 'r') do |file|

  file.each_line do |line|
    tmp << cn(line)
  end

end

pp tmp.sum()
