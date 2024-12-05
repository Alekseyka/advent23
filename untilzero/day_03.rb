puts "Input:"

raw = STDIN.readline(sep="\0").chomp

print "Sum of All mul(*,*): "
puts raw.scan(/mul\((\d+),(\d+)\)/i).map{ |v| v[0].to_i * v[1].to_i }.sum


arr = raw.scan(/(?:(do\(\))|(don\'t\(\))|mul\((\d+),(\d+)\))/i)
go = true
sum = 0

arr.each do |a|
  if(a[0] == "do()")
    go = true
  elsif(a[1] == "don't()")
    go = false
  end
  
  if go
    sum += (a[2].to_i * a[3].to_i)
  end
end

puts "Sum of do() mul(*,*): #{sum}"