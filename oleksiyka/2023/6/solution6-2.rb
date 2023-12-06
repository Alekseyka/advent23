#!/usr/bin/env ruby

require 'awesome_print'
require 'pry'

the_arr = {
  times: [],
  distances: []
}
win_count = 1

# I edited input file and that's all(:
File.foreach('input.txt') do |line|
  the_arr[:times] = line.scan(/\d+/).map(&:to_i) if line.include?('Time')
  the_arr[:distances] = line.scan(/\d+/).map(&:to_i) if line.include?('Distance')
end

the_arr[:times].each.with_index do |time, index|
  this_race_wins = 0
  time.times do |seconds|
    if (time - seconds) * seconds > the_arr[:distances][index]
      this_race_wins += 1
    end
  end
  win_count *= this_race_wins
end

ap the_arr
ap win_count

