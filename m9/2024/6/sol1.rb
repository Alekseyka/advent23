#!/usr/bin/env ruby

require_relative '../common'
require 'pry'
$get.day(6)

file = File.read($o[:test] ? 'example.txt' : 'input.txt')

# ht = Hash.new {|h,k| h[k]=[] } # init with empty arrays

map = []
obstacles = []
init_guard = {}

file.each_line do |line|
  map << line.strip.split("") 
end

@map_walk = map.dup

map.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    obstacles << [i, j] if map[i][j] == '#'
    init_guard = { marker: map[i][j], position: [i, j] } if %w[v < > ^].include?(map[i][j])
  end
end

@rotations = {
  '^' => '>', # j--, i=0
  '>' => 'v', # i++, j=0 
  'v' => '<', # j++, i=0
  '<' => '^', # i--, j=0
}

@steps = 0
@tmp_map = map.dup


def walk(cursor, map)
  start_i = cursor[:position][0]
  start_j = cursor[:position][1]
  
  i, j = start_i, start_j
  
  # puts "si=#{i}, sj=#{j}, marker=#{map[i][j]}"

  return if (i > map.size - 1 ) || (j > map[0].size - 1)
  
  marker = cursor[:marker]
  
  case marker
  when '^'
    i -= 1
  when '>'
    j += 1
  when 'v'
    i += 1
  when '<'
    j -= 1
  else
    puts 'how did we ended up here?'
  end

  # tmp_map = map.dup
  @tmp_map[start_i][start_j] = 'X'
  # puts @tmp_map.map { |x| x.join(' ') }
  puts 
  

  
  if map[i][j] == '#'
    i, j = start_i, start_j
    marker = @rotations[marker]
  end

  cursor = { marker: marker, position: [i, j] }
  
  return if i < 0 || j < 0 || i > map.size - 1 || j > map[0].size - 1
  
  walk(cursor, map)
end

cursor = { marker: init_guard[:marker], position: init_guard[:position] }

# ap cursor
# pp map


begin
  walk(cursor, map)
rescue
  # puts "error"
ensure
  ap @tmp_map.flatten.tally["X"]
end
