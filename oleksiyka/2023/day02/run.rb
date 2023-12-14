require "awesome_print"

sum = 0
game = {
  red: 0,
  green: 0,
  blue: 0
}
c_str = '\d{day01,} (?:red|green|blue)(?:, \d{day01,} (?:red|green|blue))?(?:, \d{day01,} (?:red|green|blue))?'

File.foreach("in.txt") do |line|
  line =~ /^Game (\d{day01,})/
  game_number = $1.to_i
  # puts "Game number: #{game_number}"

  line = line.sub("\n", ';')
  scan = line.scan(Regexp.new(c_str))

  this_game = game.dup
  scan.each do |draw|

    %w[red green blue].each do |color|

      draw =~ /(\d{day01,}) #{color}/
      number = $1.to_i
      this_game[color.to_sym] = number if number > this_game[color.to_sym]
      # ap({ 'color': color, 'draw': number, 'max': this_game[color.to_sym] })
    end

  end

  sum += this_game[:red] * this_game[:green] * this_game[:blue]
  ap this_game
end

puts "Games sum: #{sum}"
