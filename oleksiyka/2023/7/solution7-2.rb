#!/usr/bin/env ruby

require 'awesome_print'

result = 0

strongest_combinations_by_active_cards = {
  '5': :five_kind,
  '4': :four_kind,
  '3': :three_kind,
  '2': :one_pair,
  '1': :higher_card
}.freeze
active_cards = {
  five_kind: 5, four_kind: 4, full_house: 5, three_kind: 3, two_pair: 4, one_pair: 2, higher_card: 1
}.freeze
win_conditions = {
  five_kind: 700, four_kind: 600, full_house: 500, three_kind: 400, two_pair: 300, one_pair: 200, higher_card: 100
}.freeze
win_cards = {
  'a': 14, 'k': 13, 'q': 12, 'j': 1, 't': 10, '9': 9, '8': 8, '7': 7, '6': 6, '5': 5, '4': 4, '3': 3, '2': 2
}.freeze

def calculate_hand(combination, jokers, hand)
  ap "hand: #{hand}, jokers: #{jokers}, comb: #{combination}"
  return combination if jokers == 0
  return :four_kind if combination == :two_pair && jokers == 2
  return :full_house if combination == :two_pair && jokers == 1
  return :four_kind if combination == :three_kind && jokers == 3
  return :two_pair if combination == :one_pair && jokers == 1
  return :three_kind if combination == :one_pair && jokers == 2

  ac = active_cards[combination] + jokers
  ac = 5 if ac > 5
  strongest_combinations_by_active_cards[ac.to_s.to_sym]
end

hands = []

file.foreach('input.txt') do |line|
  scan = line.scan(/(\w{5}) (\d+)/).map { |i| { hand: i[0], bid: i[1].to_i } }[0]

  sorted_hand = scan[:hand].chars.sort.join
  joker_count = sorted_hand.gsub(/[^j]/, '').length

  the_combination = case true
                    when !(sorted_hand =~ /(.)\1{4}/).nil?
                      :five_kind
                    when !(sorted_hand =~ /(.)\1{3}/).nil?
                      :four_kind
                    when !(sorted_hand =~ /((.)\2(.)\3{2}|(.)\4{2}(.)\5)/).nil?
                      :full_house
                    when !(sorted_hand =~ /(.)\1{2}/).nil?
                      :three_kind
                    when !(sorted_hand =~ /(.)\1.?(.)\2/).nil?
                      :two_pair
                    when !(sorted_hand =~ /(.)\1/).nil?
                      :one_pair
                    else
                      :higher_card
                    end
  new_combination = calculate_hand(the_combination, joker_count, sorted_hand)
  ap "hand: #{sorted_hand}, jokers: #{joker_count}, comb: #{the_combination} --> #{new_combination}"
  scan[:sort0] = win_conditions[new_combination]

  scan[:sort1] = win_cards[scan[:hand][0].to_sym]
  scan[:sort2] = win_cards[scan[:hand][1].to_sym]
  scan[:sort3] = win_cards[scan[:hand][2].to_sym]
  scan[:sort4] = win_cards[scan[:hand][3].to_sym]
  scan[:sort5] = win_cards[scan[:hand][4].to_sym]
  hands.push(scan)
end

sorted_hands = hands.sort_by { |h| [h[:sort0].to_i, h[:sort1].to_i, h[:sort2].to_i, h[:sort3].to_i, h[:sort4].to_i, h[:sort5].to_i] }

sorted_hands.each.with_index do |hand, index|
  result += hand[:bid] * (index + 1)
end

# ap sorted_hands
# ap hands
# ap num_hands
puts "result: '#{result}'"
