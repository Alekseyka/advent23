puts "Input:"

raw = STDIN.readline(sep="\0").chomp.split(/\r?\n/).map{ |a| a.split(/\s+/).map(&:to_i) }

safe = 0
dsafe = 0
unsafe = 0
dunsafe = 0


def safe(arr)
  return false unless arr.is_a?(Array)
  return false if(arr != arr.sort && arr != arr.sort.reverse)
  arr.each_with_index do |v,i|
    next unless arr[i+1]
    v = (arr[i] - arr[i+1]).abs
    return false if (v < 1 || v > 3)
  end
  return true
end

raw.each do |a|
  if(!safe(a))
    puts "RAW UNSAFE: #{a}"
    unsafe += 1
  else
    puts "RAW SAFE: #{a}"
    safe += 1
    dsafe += 1
    next
  end
   
  ok = false
  (0 ... a.length).each do |i|
    b = a.dup
    b.delete_at(i)
    if(safe(b))
      puts "ECC SAFE: #{b}"
      ok = true
      break
    end
  end
  
  if ok
    puts "ECC SAFE: #{a}"
    dsafe += 1;
  else
    puts "ECC UNSAFE: #{a}"
    dunsafe += 1
  end
end

puts "Total Pairs: #{raw.length}"
puts "Raw Safe: #{safe}"
puts "Raw Unsafe: #{unsafe}"
puts "ECC Safe: #{dsafe}"
puts "ECC Unsafe: #{dunsafe}"