#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../common'

# rubocop:disable Style/GlobalVars
$get.day(11)
input = File.read($o[:test] ? 'example.txt' : 'input.txt').strip.split(' ').map(&:to_i)
# rubocop:enable Style/GlobalVars

# Memoization cache for number processing
NUMBER_CACHE = {}

def process_number(num)
  return NUMBER_CACHE[num] if NUMBER_CACHE.key?(num)

  result = if num.zero?
             [1]
           else
             str_num = num.to_s
             if str_num.length.even?
               mid = str_num.length / 2
               [str_num[0...mid].to_i, str_num[mid..].to_i]
             else
               [2024 * num]
             end
           end

  NUMBER_CACHE[num] = result
  result
end

def process_with_counts(number_counts)
  new_counts = Hash.new(0)

  number_counts.each do |num, count|
    results = process_number(num)
    results.each { |result| new_counts[result] += count }
  end

  new_counts
end

class SequenceAnalyzer
  def initialize(input)
    @initial_state = input.tally
  end

  def find_cycle_and_predict(max_iterations)
    current = @initial_state.dup
    seen_states = {}
    sequence_lengths = []

    max_iterations.times do |i|
      # Store current sequence length
      sequence_lengths << current.values.sum

      # Create a unique key for the current state
      state_key = current.to_a.sort.to_s

      # Check for cycle
      if seen_states[state_key]
        cycle_start = seen_states[state_key]
        cycle_length = i - cycle_start

        puts "Found cycle! Start: #{cycle_start}, Length: #{cycle_length}"

        # If we found a cycle, we can predict the final state
        remaining_iterations = (max_iterations - i) % cycle_length

        # Fast-forward to the end
        remaining_iterations.times do
          current = process_with_counts(current)
        end

        return {
          result: current.values.sum,
          cycle_found: true,
          cycle_start: cycle_start,
          cycle_length: cycle_length
        }
      end

      seen_states[state_key] = i
      current = process_with_counts(current)

      # Early exit conditions
      if current.empty?
        return {
          result: 0,
          cycle_found: false,
          empty_at: i + 1
        }
      end
    end

    # If we get here, we didn't find a cycle within max_iterations
    {
      result: current.values.sum,
      cycle_found: false
    }
  end
end

def solve_part1(input, iterations)
  analyzer = SequenceAnalyzer.new(input)
  result = analyzer.find_cycle_and_predict(iterations)

  if result[:cycle_found]
    puts "Found cycle starting at iteration #{result[:cycle_start]} with length #{result[:cycle_length]}"
  elsif result[:empty_at]
    puts "Sequence became empty at iteration #{result[:empty_at]}"
  else
    puts "No cycle found within #{iterations} iterations"
  end

  result[:result]
end

# Main execution
max_iterations = 75 # Adjust as needed
result = solve_part1(input, max_iterations)
pp "Final result: #{result}"

# Optional: Add debug information about the sequence
if $o[:debug]
  puts "\nNumber cache stats:"
  puts "Cache size: #{NUMBER_CACHE.size}"
  puts "Largest cached number: #{NUMBER_CACHE.keys.max}"
  puts "Smallest cached number: #{NUMBER_CACHE.keys.min}"
end
