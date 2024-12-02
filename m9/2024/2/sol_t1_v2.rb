#!/usr/bin/env ruby

require_relative '../common'
$get.day(2)

input   = File.read($o[:test] ? 'example.txt' : 'input.txt') 
reports = input.each_line.map {
  _1.split.map(&:to_i)
}

def check_report(report)
  check_up = report.each_cons(2).all? { |a, b| a < b }
  check_down = report.each_cons(2).all? { |a, b| a > b }
  delta = report.each_cons(2).all? { |a, b| (b - a).abs <=3 }
  
  (check_up || check_down) && delta
end

reports.each.map { |report| check_report(report) }
       .filter { _1 == true }
       .count
       .tap {ap _1}
