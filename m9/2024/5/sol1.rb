#!/usr/bin/env ruby

require_relative '../common'
$get.day(5)

input = File.read($o[:test] ? 'example.txt' : 'input.txt')

orders = []
pages = []
correct = []

input.each_line do |line|
  orders << line.chop.split("|").map(&:to_i) if line.include?( "|")
  pages << line.chop.split(",").map(&:to_i) if line.include?(",")
end

pages.each do |page|
  rules = []
  
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
      next 
    end
  end
  
  

  if incorrect_rules == 0
    correct << page[page.length / 2]
    pp page
    pp page.length / 2
    pp rules
  end
  
end

ap correct.sum

# ap orders
# ap pages