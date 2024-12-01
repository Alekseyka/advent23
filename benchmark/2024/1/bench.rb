require 'benchmark'
FNAME = 'input.txt'

module Leks
  def self.sol1
    a1 = []
    a2 = []

    File.foreach(FNAME) do |line|
      number1, number2 = line.split.map(&:to_i)

      a1.push(number1)
      a2.push(number2)
    end

    a1 = a1.sort
    a2 = a2.sort

    s1 = 0

    a1.each.with_index do |number1, i|
      s1 += (number1 - a2[i]).abs
    end

    s1

  end
  
  def self.sol2
    a1 = []
    a2 = []

    File.foreach(FNAME) do |line|
      number1, number2 = line.split.map(&:to_i)

      a1.push(number1)
      a2.push(number2)
    end

    a1 = a1.sort
    a2 = a2.sort

    s2 = 0

    a1.each.with_index do |number1, i|
      s2 += number1 * a2.count(number1)
    end

    s2
  end
end

module Tania
  def self.sol1
    list1 = []
    list2 = []

    File.open(FNAME, 'r') do |file|
      file.each_line do |line|
        list1 << line.split("   ")[0].to_i
        list2 << line.split("   ")[1].to_i
      end
    end

    list1.sort!
    list2.sort!
    res = 0

    list1.each_with_index do |el, index|
      res += (el - list2[index]).abs
    end

    res
  end
  
  def self.sol2
    list1 = []
    list2 = {}

    File.open(FNAME, 'r') do |file|
      file.each_line do |line|
        char = line.split("   ")[1].to_i
        list1 << line.split("   ")[0].to_i
        unless list2[char].nil?
          list2[char] += 1
        else
          list2[char] = 1
        end
      end
    end

    res = 0

    list1.each do |el|
      next if list2[el].nil?
      res += el * list2[el]
    end

    res
  end
end

module Mos
  def self.sol1
    file_data = nil

    File.open(FNAME, 'r') do |f|
      file_data = f.each_line.map {|l| l.match(/(\d+)\s+(\d+)/).captures}
    end

    file_data = file_data.to_a.map {|a| a.map &:to_i}

    arr_l =(file_data.map &:first).sort
    arr_r =(file_data.map &:last).sort

    arr_sol_1 = [arr_l, arr_r].transpose.map { |x| x.reduce &:- }.map(&:abs).reduce &:+

    arr_sol_1
  end
  
  def self.sol2
    file_data = nil

    File.open(FNAME, 'r') do |f|
      file_data = f.each_line.map {|l| l.match(/(\d+)\s+(\d+)/).captures}
    end

    file_data = file_data.to_a.map {|a| a.map &:to_i}

    arr_l =(file_data.map &:first).sort
    arr_r =(file_data.map &:last).sort

    arr_sol_2 = arr_l.map {|x| x*arr_r.count(x)}.reduce &:+

    arr_sol_2
  end
end

n = 1000

Benchmark.bm(30) do |x|
  x.report("Leks | Day 1 | Task 1: ") {n.times { Leks.sol1 }}
  x.report("Leks | Day 1 | Task 2: ") {n.times { Leks.sol2 }}
  x.report("Tania | Day 1 | Task 1: ") {n.times { Tania.sol1 }}
  x.report("Tania | Day 1 | Task 2: ") {n.times { Tania.sol2 }}
  x.report("Mos | Day 1 | Task 1: ") {n.times { Mos.sol1 }}
  x.report("Mos | Day 1 | Task 2: ") {n.times { Mos.sol2 }}
end