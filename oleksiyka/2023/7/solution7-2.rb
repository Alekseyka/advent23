#!/usr/bin/env ruby

require 'awesome_print'

result = 0

STRONGEST_COMBINATIONS_BY_ACTIVE_CARDS = {
  '5': :five_kind,
  '4': :four_kind,
  '3': :three_kind,
  '2': :one_pair,
  '1': :higher_card
}.freeze
ACTIVE_CARDS = {
  five_kind: 5, four_kind: 4, full_house: 5, three_kind: 3, two_pair: 4, one_pair: 2, higher_card: 1
}.freeze
WIN_CONDITIONS = {
  five_kind: 700, four_kind: 600, full_house: 500, three_kind: 400, two_pair: 300, one_pair: 200, higher_card: 100
}.freeze
WIN_CARDS = {
  'A': 14, 'K': 13, 'Q': 12, 'J': 1, 'T': 10, '9': 9, '8': 8, '7': 7, '6': 6, '5': 5, '4': 4, '3': 3, '2': 2
}.freeze

def calculate_hand(combination, jokers, hand)
  return combination if jokers == 0
  return :four_kind if combination == :two_pair && jokers == 2
  return :full_house if combination == :two_pair && jokers == 1
  return :four_kind if combination == :three_kind && jokers == 3
  return :three_kind if combination == :one_pair && jokers == 1
  return :three_kind if combination == :one_pair && jokers == 2

  ac = ACTIVE_CARDS[combination] + jokers
  ac = 5 if ac > 5
  STRONGEST_COMBINATIONS_BY_ACTIVE_CARDS[ac.to_s.to_sym]
end

hands = []

File.foreach('input.txt') do |line|
  scan = line.scan(/(\w{5}) (\d+)/).map { |i| { hand: i[0], bid: i[1].to_i } }[0]

  sorted_hand = scan[:hand].chars.sort.join
  joker_count = sorted_hand.gsub(/[^J]/, '').length

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
  ap "Hand: #{sorted_hand}, jokers: #{joker_count}, comb: #{the_combination} --> #{new_combination}" if joker_count > 0
  scan[:sort0] = WIN_CONDITIONS[new_combination]

  scan[:sort1] = WIN_CARDS[scan[:hand][0].to_sym]
  scan[:sort2] = WIN_CARDS[scan[:hand][1].to_sym]
  scan[:sort3] = WIN_CARDS[scan[:hand][2].to_sym]
  scan[:sort4] = WIN_CARDS[scan[:hand][3].to_sym]
  scan[:sort5] = WIN_CARDS[scan[:hand][4].to_sym]
  hands.push(scan)
end

sorted_hands = hands.sort_by { |h| [h[:sort0].to_i, h[:sort1].to_i, h[:sort2].to_i, h[:sort3].to_i, h[:sort4].to_i, h[:sort5].to_i] }

sorted_hands.each.with_index do |hand, index|
  result += hand[:bid] * (index + 1)
end

# ap sorted_hands
# ap hands
# ap num_hands
puts "Result: '#{result}'"
