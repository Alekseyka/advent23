#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

@parts = []
@workflows = {}

@steps = File.read(filename).split("\n\n")[0].split("\n").map do |line|
  split = line.split('{')
  name = split[0]
  groups = split[1][..-2].split(',')
  groups = groups.map do |g|
    scan = g.scan(/(?:([xmas])([><])(\d+):)?(\w+)/)[0]
    {
      part: scan[0]&.to_sym,
      comparator: scan[1],
      number: scan[2]&.to_i,
      result: scan[3]
    }
  end
  @workflows[name] = groups
end
@workflows['A'] = [:process_a]
@workflows['R'] = [:process_r]

@sum = 0

def split_range(range, number, comparator)
  r1 = range.first
  position = number - r1
  new_range1 = comparator == '>' ? range[(position + 1)..] : range[..(position - 1)]
  new_range2 = comparator == '>' ? range[..position] : range[position..]
  [new_range1, new_range2]
end

def process_workflow(wf, x_r, m_r, a_r, s_r)
  wf.each do |rule|
    # ap rule
    if rule == :process_a
      @sum += x_r.length * m_r.length * a_r.length * s_r.length
      break
    elsif rule == :process_r
      break
    end

    next_wf = @workflows[rule[:result]]

    if rule[:part].nil?
      process_workflow(next_wf, x_r, m_r, a_r, s_r)
      next
    end

    case rule[:part]
    when :x
      split_range(x_r, rule[:number], rule[:comparator]) => [new_x_r, x_r]
      process_workflow(next_wf, new_x_r, m_r, a_r, s_r)
    when :m
      split_range(m_r, rule[:number], rule[:comparator]) => [new_m_r, m_r]
      process_workflow(next_wf, x_r, new_m_r, a_r, s_r)
    when :a
      split_range(a_r, rule[:number], rule[:comparator]) => [new_a_r, a_r]
      process_workflow(next_wf, x_r, m_r, new_a_r, s_r)
    when :s
      split_range(s_r, rule[:number], rule[:comparator]) => [new_s_r, s_r]
      process_workflow(next_wf, x_r, m_r, a_r, new_s_r)
    end

  end
end

process_workflow(@workflows['in'], (1..4000).to_a, (1..4000).to_a, (1..4000).to_a, (1..4000).to_a)

puts @sum
