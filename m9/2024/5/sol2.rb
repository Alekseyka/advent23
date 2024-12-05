#!/usr/bin/env ruby

require_relative '../common'
$get.day(5)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

orders = []
pages = []
correct = []
incorrect = {}

input.each_line do |line|
  orders << line.strip.split("|").map(&:to_i) if line.include?( "|")
  pages << line.strip.split(",").map(&:to_i) if line.include?(",")
  # ap line
end

pages.each do |page|
  # ap page
  rules = []
  bad_rules = []

  orders.each do |order|
    rules << order if page.include?(order[0]) && page.include?(order[1])
  end

  incorrect_rules = 0

  rules.each do |rule|

    idx_l = page.find_index(rule[0])
    idx_r = page.find_index(rule[1])

    next if idx_l.nil?
    next if idx_r.nil?

    if idx_l > idx_r
      incorrect_rules += 1
      bad_rules << rule
      next
    end
  end



  if incorrect_rules > 0
    incorrect[page] = { all: rules, bad: bad_rules }
  end
end

def sorter(rules, a, b)
  # puts "rules = #{rules}"
  # puts "a = #{a}, b = #{b}"
  # puts "#{rules.find_index([a, b])}"
  # puts "#{rules.find_index([b, a])}"
  
  return -1 if rules.find_index([a, b])
  return 1 if rules.find_index([b, a])
  nil
end

fixed = []

incorrect.each do |k, v| 
  page = k
  rules = v[:all]
  puts "page = #{page}"
  fixed << page.sort do |a, b|
    sorter(rules, a, b)
  end
end

ap fixed.map { _1[_1.length / 2]}.sum
