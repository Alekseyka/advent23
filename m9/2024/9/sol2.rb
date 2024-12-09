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
require 'matrix'

$get.day(9)

input = File.read($o[:test] ? 'example.txt' : 'input.txt').strip.split('').map(&:to_i)
files = []
free_space = []
full_disk = []

files = input.each.with_index.select {|_, idx| idx % 2 == 0 }.map(&:first)
free_space = input.each.with_index.select {|_, idx| idx % 2 != 0 }.map(&:first)
current_file = 0

files.each.with_index do |file, idx|
  # next if idx == files.size - 1
  free_space_count = free_space[idx] || 0
  file.times { full_disk << current_file }
  free_space_count.times { full_disk << '.' }
  current_file += 1
end

empty_indexes = full_disk.each.with_index.select {|el, _| el == '.' }.map(&:last)

# pp input
# pp files
# pp free_space
# pp full_disk.join('')

def get_space(ary)
  ary.chunk{|y| y}.map{|y, ys| {s: y.to_s*ys.length, moved: false}}
end

full_disk_x = get_space(full_disk)
# full_disk_x


def defrag(ary)
  slot = ary.each_with_index.detect {|e, idx| e[:s].include?('.')}
  l = slot.last
  l_size = slot[0][:s].size
  
  movable = ary.reverse.each_with_index.detect {|e, idx| ( e[:s].size <= l_size && !e[:s].include?('.') && !e[:moved]) }
  
  return ary unless movable
  
  r = ary.size - 1 - movable.last
  r_size = movable[0][:s].size

  if l_size == r_size
    ary[l], ary[r] = ary[r], ary[l]
    ary[l][:moved] = true
  else
    # binding.pry
    ary.delete_at(r)
    ary.insert(l, movable.first)
    ary[l][:moved] = true
    ary[l+1] = { s: '.'*(l_size-r_size), moved: false }
    ary[r+1] = { s: '.'*slot.size, moved: false }
  end
  
  defrag(ary)
end

# full_disk_x[-1] = '9999'
tmp = defrag(full_disk_x)
ap tmp

tmp = tmp.map {_1[:s]}.join
pp tmp


sum = 0
tmp.split('').each_with_index do |el, idx|
  sum += el.to_i * idx unless el == '.'
end

pp sum


# pp full_disk_x

# defrag_disk = full_disk.clone
# defrag_disk_x = get_space(defrag_disk)
#
# tmp_disk = defrag_disk.clone
# tmp_disk_x = get_space(tmp_disk)
#
# defrag_disk_x.each_with_index do |el|
#   if el.first == '.'
#     size = el.last
#     el_to_move = defrag_disk_x.reverse.detect {|e| e.last <= size}
#     tmp_disk_x
#    
#   end
# end


# spaces = full_disk_x.each_with_index.select { |x, idx| x.first == '.' }
# files  = full_disk_x.each_with_index.select { |x, idx| x.first != '.' }
#
# pp spaces
# pp files
#



# full_disk_x.each do |el|
#  
#
#  
#   if el.first == '.'
#     size = el.last
#   end
# end
