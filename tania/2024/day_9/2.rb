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
disk3 = []
disk.chars.each do |c|
  if cur_sym == "num"
    cur_sym = "dot"
    disk3 << {q: c.to_i, val: cur_num} unless c == '0'
    cur_num += 1 unless c == '0'
  else 
    cur_sym = "num"
    disk3 << {q: c.to_i, val: "."} unless c == '0'
  end
end
val_mv = Array.new(cur_num, false)

j = disk3.size - 1
added = 0
while j >= 0 do
  h = disk3[j]
#   pp "j #{j} #{h}"
#   pp disk3
  if h[:val] != '.' && val_mv[h[:val]] == false
    val_mv[h[:val]] = true
    ins = disk3[0..(j-1)].find {|hh| hh[:val] == '.' && hh[:q] >= h[:q]} unless j == 0
    # pp "ins #{ins} #{ins.nil?}"
    unless ins.nil?
        if ins[:q] == h[:q]
            ins[:val] = h[:val]
        else
            k = disk3.index(ins)
            diff_q = ins[:q] - h[:q]
            ins[:val] = h[:val]
            ins[:q] = h[:q]
            disk3.insert(k + 1 , {q: diff_q, val: '.'})
            added += 1
            j += added 
        end
        h[:val] = '.'
    end
  end
  j -= 1
end

disk3.each do |h|
  if h[:val] != '.'
    disk2 << Array.new(h[:q], h[:val])
  else 
    disk2 << Array.new(h[:q], '.')
  end
end

disk2.flatten.each_with_index do |c, i|
    next if c == '.'
    res += i * c 
end
# pp disk2
pp res