#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# rubocop:disable Style/GlobalVars
$get.day(11)

input = File.read($o[:test] ? 'example.txt' : 'input.txt').strip.split(' ').map(&:to_i)
# rubocop:enable Style/GlobalVars

def apply_rules(input)
  return if input.class == Integer

  result = []

  input.each do |i|
    string_i = i.to_s

    if i.zero?
      result << 1
      next
    end

    if string_i.length.even?
      mid = string_i.length / 2
      left = string_i[0...mid].to_i
      right = string_i[mid..].to_i

      result << left.to_i
      result << right.to_i

      next
    end

    result << 2024 * i
  end

  result
end

iterations = Hash.new([])

iterations[0] = input

def iterate(cursor, max_iter, hash)
  return if cursor >= max_iter

  current = hash[cursor]
  hash[cursor + 1] = apply_rules(current)

  iterate(cursor + 1, max_iter, hash)
end

iterate(0, 25, iterations)

pp iterations.values.last.size
