q = 0

f = File.read('in.txt')

entries = f.scan(Regexp.union(/(mul\((\d+),(\d+)\))/, /(do\(\))/, /(don't\(\))/))
p entries

enabled = true

entries.each do |entry|
  p entry
  if entry[4] != nil
    enabled = false
    p 'set false'
    next  # dont
  end

  enabled = true and p 'set true' and next if entry[3] != nil # do

  p "!!!!! #{entry}" if entry[0] == nil

  q += entry[1].to_i * entry[2].to_i if entry[1] != nil && enabled
end
p q