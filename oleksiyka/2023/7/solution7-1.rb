#!/usr/bin/env ruby

require 'awesome_print'

result = 0
num_hands = 0

win_conditions = {
  five_kind: 700, four_kind: 600, full_house: 500, three_kind: 400, two_pair: 300, one_pair: 200, higher_card: 100
}
win_cards = {
  'A': 14, 'K': 13, 'Q': 12, 'J': 11, 'T': 10, '9': 9, '8': 8, '7': 7, '6': 6, '5': 5, '4': 4, '3': 3, '2': 2,
}

hands = []

File.foreach('input.txt') do |line|
  scan = line.scan(/(\w{5}) (\d+)/).map { |i| { hand: i[0], bid: i[1].to_i } }[0]

  sorted_hand = scan[:hand].chars.sort.join

  scan[:sort0] = case true
                 when !(sorted_hand =~ /(.)\1{4}/).nil?
                   win_conditions[:five_kind]
                 when !(sorted_hand =~ /(.)\1{3}/).nil?
                   win_conditions[:four_kind]
                 when !(sorted_hand =~ /((.)\2(.)\3{2}|(.)\4{2}(.)\5)/).nil?
                   win_conditions[:full_house]
                 when !(sorted_hand =~ /(.)\1{2}/).nil?
                   win_conditions[:three_kind]
                 when !(sorted_hand =~ /(.)\1.?(.)\2/).nil?
                   win_conditions[:two_pair]
                 when !(sorted_hand =~ /(.)\1/).nil?
                   win_conditions[:one_pair]
                 else
                   win_conditions[:higher_card]
                 end

  scan[:sort1] = win_cards[scan[:hand][0].to_sym]
  scan[:sort2] = win_cards[scan[:hand][1].to_sym]
  scan[:sort3] = win_cards[scan[:hand][2].to_sym]
  scan[:sort4] = win_cards[scan[:hand][3].to_sym]
  scan[:sort5] = win_cards[scan[:hand][4].to_sym]
  hands.push(scan)
end
num_hands = hands.length

sorted_hands = hands.sort_by { |h| [h[:sort0].to_i, h[:sort1].to_i, h[:sort2].to_i, h[:sort3].to_i, h[:sort4].to_i, h[:sort5].to_i] }

sorted_hands.each.with_index do |hand, index|
  ap index
  result += hand[:bid] * (index + 1)
end

# ap hands
# ap num_hands
puts "Result: '#{result}'"
