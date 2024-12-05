puts "Input:"

raw = STDIN.readline(sep="\0").chomp.split(/\r?\n/)

raw.map!{ |m| m.split(/\s+/) }
a = raw.map(&:shift).map(&:to_i).sort
b = raw.map(&:shift).map(&:to_i).sort
t = b.tally

total = 0;
pairs = 0;
sim = 0

a.each_with_index do |num, i|
  puts "A[i]: #{a[i]} - B[i]: #{b[i]} = #{ (a[i] - b[i]).abs}"
  total += (a[i] - b[i]).abs
  sim += num * ((t.include?(num)) ? t[num].to_i : 0)
  pairs += 1
end

puts "Pairs: #{pairs}"
puts "Total: #{total}"
puts "Similarity: #{sim}"