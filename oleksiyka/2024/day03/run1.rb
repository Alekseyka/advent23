q = 0

f = File.read('in.txt')

muls = f.scan(/mul\((\d+),(\d+)\)/)

muls.each do |mul|
  p mul
  q += mul[0].to_i * mul[1].to_i
end
p q