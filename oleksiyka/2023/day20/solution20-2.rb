#!/usr/bin/env ruby

require 'awesome_print'

filename = 'input.txt'
# filename = 'example.txt'

class Module
  MOD_TYPES = {
    '%': :ff,
    '&': :con,
    'b': :broadcast
  }.freeze
  attr_accessor :name, :type, :outputs, :ff_state, :some

  def initialize(line)
    split = line.split(' -> ')
    @type = MOD_TYPES[split[0][0].to_sym] || (raise "no type for #{split[0][0]}")
    @name = type == :broadcast ? split[0] : split[0][1..]
    @outputs = split[1].split(', ')
    @ff_state = false
    @some = 0
  end

  def receive_pulse(pulse, con_received_pulses)
    case type
    when :ff
      ff_process pulse
    when :con
      con_process con_received_pulses
    when :broadcast
      { pulse:, receivers: outputs }
    else
      raise "wrong type: #{type}"
    end
  end

  def ff_process(pulse)
    return nil if pulse == :high

    self.ff_state = !ff_state
    new_pulse = ff_state ? :high : :low
    { pulse: new_pulse, receivers: outputs }
  end

  def con_process(con_received_pulses)
    new_pulse = con_received_pulses.values.uniq == [:high] ? :low : :high
    { pulse: new_pulse, receivers: outputs }
  end

  def con?
    type == :con
  end

  def ff?
    type == :ff
  end

  def to_s
    "#{MOD_TYPES.key(type)}#{name} -> #{outputs.to_a.join(', ')}"
  end
end

@modules = []
@con_modules = []
@ff_modules = []

@steps = File.read(filename).split("\n").each do |line|
  m = Module.new(line)
  @modules.push(m)
  @con_modules.push(m) if m.con?
  @ff_modules.push(m) if m.ff?
end

@default_con_pulses = {}
@con_modules.each do |m|
  @default_con_pulses[m.name] = @modules.find_all { |mod| mod.outputs.include?(m.name) }.to_h { |sup| [sup.name, false] }
end
@con_pulses = @default_con_pulses.dup

@pulses_count = { low: 0, high: 0 }
@memo = {}
# @modules.each { |m| puts m }
n = 10000
n.times do |i|
  @pulses_count[:low] += 1
  @pulses = [{ pulse: :low, receivers: ['broadcaster'] }]
  state = @ff_modules.map { |m| m.ff_state ? '1' : '0' }.join
  # puts "state: #{state} - #{i}"
  # break unless @memo[state].nil?

  @memo[state] = i
  until @pulses.empty?
    @next_pulses = []
    @next_con_pulses = @default_con_pulses.dup
    @pulses.each do |pulse|
      pulse[:receivers].each do |receiver_name|
        next if %w[output rx].include? receiver_name

        the_module = @modules.find { |m| m.name == receiver_name }
        result = the_module.receive_pulse(pulse[:pulse], @con_pulses[receiver_name])
        next if result.nil?

        if %w[vn hn kt ph].include?(receiver_name) && the_module.some < 5 && result[:pulse] == :high
          puts "--------MODULE #{receiver_name} - 1!!! - #{i + 1}"
          # then - LCM all 4 results
          the_module.some += 1
        end

        @pulses_count[result[:pulse]] += result[:receivers].length
        result[:receivers].each do |result_receiver_name|
          # puts "#{receiver_name} -#{result[:pulse]} -> #{result_receiver_name}"
          next if %w[output rx].include? result_receiver_name

          result_module = @modules.find { |m| m.name == result_receiver_name }
          @next_con_pulses[result_receiver_name][receiver_name] = result[:pulse] if result_module.con?
        end

        @next_pulses.push(result)
      end
    end

    @pulses = @next_pulses
    @con_pulses = @next_con_pulses
  end
end

ap @pulses_count
puts @pulses_count[:low] * @pulses_count[:high]