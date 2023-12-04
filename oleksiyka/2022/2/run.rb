require 'awesome_print'
# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors
# 1 for Rock, 2 for Paper, and 3 for Scissors
# 0 if you lost, 3 if the round was a draw, and 6 if you won

sum = 0
WIN_POINTS = {
  'X': {
    'A': 3, 'B': 0, 'C': 6
  },
  'Y': {
    'A': 6, 'B': 3, 'C': 0
  },
  'Z': {
    'A': 0, 'B': 6, 'C': 3
  }
}.freeze

MY_SHAPES = {
  'X': {
    'A': :Z, 'B': :X, 'C': :Y
  },
  'Y': {
    'A': :X, 'B': :Y, 'C': :Z
  },
  'Z': {
    'A': :Y, 'B': :Z, 'C': :X
  }
}.freeze

SHAPE_POINTS = {
  'X': 1,
  'Y': 2,
  'Z': 3
}.freeze

File.foreach('in.txt') do |line|
  his = line[0]&.to_sym
  # mine = line[2]&.to_sym
  result = line[2]&.to_sym
  mine = MY_SHAPES[result][his]
  sum += SHAPE_POINTS[mine] + WIN_POINTS[mine][his]
end

p sum
