require 'pry'

class Game
  attr_accessor :game
  attr_accessor :rounds
  attr_accessor :gg
  attr_accessor :max_number
  attr_accessor :g_power

  def initialize(game, rounds)
    self.gg = true
    self.game = game

    self.max_number = {red: 0, green: 0, blue: 0}

    self.rounds = parse(rounds).map &:to_h

    self.g_power = self.max_number[:red] * self.max_number[:green] * self.max_number[:blue]
  end

  private

  def check_game(color, number)
    rules = {
      red: 12,
      green: 13,
      blue: 14
    }

    self.gg = false if number > rules[color]
    self.max_number[color] = number if number > self.max_number[color]
  end

  def parse(rounds)
    tmp = rounds.map do |r|
      r.split(',').map(&:strip)
    end

    tmp.map do |row|
      row.map do |round|
        (v, k) = round.split(' ')
        k = k.to_sym
        v = v.to_i
        check_game(k, v)

        [k, v]
      end
    end
  end
end


def read_input
  File.read('input.txt')
end

def parse_input(file)
  good_games = []
  power_games = []
  file.each_line do |line|
    rx = /^Game (\d+): (.*)/
    m =  line.match(rx)
    game = Game.new(m[1], m[2].split(';').map(&:strip))

    good_games << game.game if game.gg
    power_games << game.g_power

  end

  [good_games, power_games]
end

file = read_input
games = parse_input(file)

pp games[0].map(&:to_i).sum()
pp games[1].sum()


