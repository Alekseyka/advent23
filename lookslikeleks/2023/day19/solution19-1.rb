#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

class Rule
  attr_accessor :part, :comparator, :number, :result

  def initialize(line)
    scan = line.scan(/(?:([xmas])([><])(\d+):)?(\w+)/)[0]
    @part = scan[0]&.to_sym
    @comparator = scan[1]
    @number = scan[2]&.to_i
    @result = scan[3]
  end

  def check_rule(metal_part)
    return result if part.nil?

    comparison = if comparator == '>'
                   metal_part.instance_variable_get("@#{part}") > number
                 else
                   metal_part.instance_variable_get("@#{part}") < number
                 end
    return result if comparison == true

    :next
  end

  def to_s
    "#{part}#{comparator}#{number}#{number ? ':' : ''}#{result}"
  end
end

class Workflow
  attr_accessor :name, :rules

  def initialize(line)
    scan = line.scan(/(\w+)\{((?:(?:[xmas][><]\d+:)?\w+,?)*)}/)[0]
    @name = scan[0]
    @rules = []
    scan[1].split(',').map do |rule_string|
      @rules.push(Rule.new(rule_string))
    end
  end

  def result_for_part(part)
    rule_result = nil
    @rules.each do |rule|
      rule_result = rule.check_rule(part)
      next if rule_result == :next

      break
    end
    rule_result
  end

  def to_s
    "#{name}{#{rules.map(&:to_s).join(',')}}"
  end
end

class MetalPart
  attr_accessor :x, :m, :a, :s

  def initialize(line)
    scan = line.scan(/\{x=(\d+),m=(\d+),a=(\d+),s=(\d+)}/)[0]
    @x = scan[0].to_i
    @m = scan[1].to_i
    @a = scan[2].to_i
    @s = scan[3].to_i
  end

  def apply_workflows(workflows)
    in_wf = workflows.find { |wf| wf.name == 'in' }
    result = in_wf.result_for_part(self)
    until %w[A R].include?(result)
      current_wf = workflows.find { |wf| wf.name == result }
      result = current_wf.result_for_part(self)
    end
    result == 'A' ? self.sum_parts : 0
  end

  def sum_parts
    x + m + a + s
  end

  def to_s
    "{x=#{x},m=#{m},a=#{a},s=#{s}}"
  end
end

@parts = []
@workflows = []

@steps = File.read(filename).split("\n\n").map do |block|
  block.split("\n").map do |line|
    if line[0] == '{'
      @parts.push(MetalPart.new(line))
    else
      @workflows.push(Workflow.new(line))
    end
  end
end

sum = 0
@parts.each do |p|
  sum += p.apply_workflows(@workflows)
end

puts "Sum: #{sum}"
