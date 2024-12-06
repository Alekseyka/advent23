#!/usr/bin/env ruby

########################################################################################################################
#
#         d8b   db  .d88b.  d888888b      db   d8b   db  .d88b.  d8888b. db   dD d888888b d8b   db  d888b
#         888o  88 .8P  Y8. `~~88~~'      88   I8I   88 .8P  Y8. 88  `8D 88 ,8P'   `88'   888o  88 88' Y8b 
#         88V8o 88 88    88    88         88   I8I   88 88    88 88oobY' 88,8P      88    88V8o 88 88      
#         88 V8o88 88    88    88         Y8   I8I   88 88    88 88`8b   88`8b      88    88 V8o88 88  ooo 
#         88  V888 `8b  d8'    88         `8b d8'8b d8' `8b  d8' 88 `88. 88 `88.   .88.   88  V888 88. ~8~
#         VP   V8P  `Y88P'     YP          `8b8' `8d8'   `Y88P'  88   YD YP   YD Y888888P VP   V8P  Y888P  
# 
########################################################################################################################

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
@walks = []
@loop_tracker = []

def walk(cursor, map)
  start_i = cursor[:position][0]
  start_j = cursor[:position][1]
  
  

  i, j = start_i, start_j
  
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
  # @tmp_map[start_i][start_j] = 'X'
  # puts @tmp_map.map { |x| x.join(' ') }
  puts



  if map[i][j] == '#'
    i, j = start_i, start_j
    marker = @rotations[marker]
  end

  cursor = { marker: marker, position: [i, j] }

  return if i < 0 || j < 0 || i > map.size - 1 || j > map[0].size - 1
  
  check_loop(cursor, map)
  walk(cursor, map)
end

def get_row(cursor, map)
  map[cursor[:position][0]]
end

def get_col(cursor, map)
  map.transpose[cursor[:position][1]]
end

@loop_count = 0

def check_loop(cursor, map)
  new_marker = @rotations[cursor[:marker]]
  arry_row = get_row(cursor, map)
  arry_col = get_col(cursor, map)
  current_i = cursor[:position][0]
  current_j = cursor[:position][1]
  pp @loop_tracker
  
  if @loop_tracker.include?([current_i, current_j])
    puts "LOOP #{current_i}:#{current_j}"
    @loop_tracker = []
    @loop_count += 1
    return
  else
    puts "Not loop!"
    @loop_tracker << [current_i,current_j]
  end
  
  
  case cursor[:marker]
  when '^'
    puts '----'
    puts "i=#{current_i}, j=#{current_j}"
    puts "arry_row=#{arry_row}"
    puts "current_j=#{current_j}, arry_cut=#{arry_row[current_j..arry_row.size - 1]}"
    walk(cursor.merge({ marker: new_marker }), map) if arry_row[current_j..arry_row.size - 1].include?('#') 
  when '>'
    puts '----'
    puts "i=#{current_i}, j=#{current_j}"
    puts "arry_col=#{arry_col}"
    puts "current_i=#{current_i}, arry_cut=#{arry_col[current_i..arry_col.size - 1]}"
    walk(cursor.merge({ marker: new_marker }), map) if arry_col[current_i..arry_col.size - 1].include?('#')
  when 'v'
    puts '----'
    puts "i=#{current_i}, j=#{current_j}"
    puts "arry_row=#{arry_row}"
    puts "current_j=#{current_j}, arry_cut=#{arry_row[0..current_j]}"
    walk(cursor.merge({ marker: new_marker }), map) if arry_row[0..current_j].include?('#')
  when '<'
    puts '----'
    puts "i=#{current_i}, j=#{current_j}"
    puts "arry_col=#{arry_col}"
    puts "current_i=#{current_i}, arry_cut=#{arry_col[0..current_i]}"
    walk(cursor.merge({ marker: new_marker }), map) if arry_col[0..current_i].include?('#')
  else
    return false
  end
end



cursor = { marker: init_guard[:marker], position: init_guard[:position] }
# cursor = { marker: '>', position:  [1, 7]}

# ap cursor
# pp map


begin
  puts map.map { |x| x.join ' ' } 
  walk(cursor, map)
rescue
  # puts "error"
ensure
  ap @tmp_map.flatten.tally["X"]
  puts "Loops=#{@loop_count}"
end
