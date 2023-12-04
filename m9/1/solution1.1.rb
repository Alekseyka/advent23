def cn(line)
  f = line[line.index(/\d/)]
  l = line.reverse[line.reverse.index(/\d/)]
  10*f.to_i + l.to_i
end

tmp = []
File.open('input.txt', 'r') do |file|

  file.each_line do |line|
    tmp << cn(line)
  end

  pp tmp.sum()
end



