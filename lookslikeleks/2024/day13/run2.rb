require 'bigdecimal'
require 'bigdecimal/util'

test = false
# test = true
filename = test ? 'test.txt' : 'in.txt'

A_PRICE = 3
B_PRICE = 1

def calculate_buttons(a, b, prize)
  const_a = (prize[1] - (prize[0] * b[1] / b[0])) / (a[1] - (a[0] * b[1] / b[0]))
  const_b = (prize[0] - a[0] * const_a) / b[0]
  [const_a, const_b]
end

q = 0

@button_a = nil
@button_b = nil
@prize = nil

File.foreach(filename) do |line|
  line = line.strip
  case line
  when /^Button A: X\+(\d+), Y\+(\d+)$/
    @button_a = [$1.to_d, $2.to_d]
  when /^Button B: X\+(\d+), Y\+(\d+)$/
    @button_b = [$1.to_d, $2.to_d]
  when /^Prize: X=(\d+), Y=(\d+)$/
    @prize = [$1.to_d + 10 ** 13, $2.to_d + 10 ** 13]
    p "Running with A: #{@button_a}, B: #{@button_b}, Prize: #{@prize}"
    a, b = calculate_buttons(@button_a, @button_b, @prize)
    if a.round(5) % 1 == 0 && b.round(5) % 1 == 0
      p "A: #{a}, B: #{b}, Prize: #{@prize} FOUND!!"
      q += A_PRICE * a.round + b.round
    end
    p '===='
  end
end
p q
