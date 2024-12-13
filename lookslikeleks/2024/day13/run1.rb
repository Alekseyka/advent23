require "matrix"

test = false
filename = test ? 'test.txt' : 'in.txt'

A_PRICE = 3
B_PRICE = 1
MAX_PRESS = 100

def calculate_buttons(button_a, button_b, prize)
  min_cost = Float::INFINITY
  found = false

  (0..MAX_PRESS).each do |a_pressed|
    (0..MAX_PRESS).each do |b_pressed|
      result = button_a * a_pressed + button_b * b_pressed
      if result == prize
        found = true
        cost = a_pressed * A_PRICE + b_pressed * B_PRICE
        min_cost = [min_cost, cost].min
      end
    end
  end

  if found
    p "A: #{button_a}, B: #{button_b}, Prize: #{prize} FOUND!!"
    min_cost
  else
    p "A: #{button_a}, B: #{button_b}, Prize: #{prize} NOT FOUND"
    0
  end
end

q = 0

@button_a = nil
@button_b = nil
@prize = nil

File.foreach(filename) do |line|
  line = line.sub(/\n/, '')
  case line
  when /^Button A: X\+(\d+), Y\+(\d+)$/
    @button_a = Vector[$1.to_i, $2.to_i]
  when /^Button B: X\+(\d+), Y\+(\d+)$/
    @button_b = Vector[$1.to_i, $2.to_i]
  when /^Prize: X=(\d+), Y=(\d+)$/
    @prize = Vector[$1.to_i, $2.to_i]
    p "Running with A: #{@button_a}, B: #{@button_b}, Prize: #{@prize}"
    q += calculate_buttons(@button_a, @button_b, @prize)
    p '===='
  end
end
p q
