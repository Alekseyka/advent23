#!/usr/bin/env ruby

require_relative '../common'
$get.day(2)

input   = File.read($o[:test] ? 'example.txt' : 'input.txt') 
reports = input.each_line.map {
  _1.split.map(&:to_i)
}

def check_report(report:, first: true)
  check_up = report.each_cons(2).all? { |a, b| a < b }
  check_down = report.each_cons(2).all? { |a, b| a > b }
  delta = report.each_cons(2).all? { |a, b| (b - a).abs <=3 }
  
  first_condition = (check_up || check_down) && delta 
  second_condition = false
  
  if first
    second_condition = report.map.with_index { |_, i| report.dup.tap { _1.delete_at(i) } }
          .map { check_report(report:_1, first: false) }
          .filter { _1 == true }
          .count > 0
  end
  
  first_condition || second_condition
  
end

reports.each.map { |report| check_report(report: report) }
       .filter { _1 == true }
       .count
       .tap {ap _1}
