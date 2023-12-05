#!/usr/bin/env ruby

require 'awesome_print'
require 'pry'

transformation_from = ''
transformation_to = ''

items = {
  seed: [],
  soil: [],
  fertilizer: [],
  water: [],
  light: [],
  temperature: [],
  humidity: [],
  location: []
}

File.foreach('input.txt') do |line|
  if line.include?('seeds')
    ranges = line.scan(/(\d+)\s(\d+)/)
    items[:seed] = ranges.map { |r| { start: r[0].to_i, end: r[0].to_i + r[1].to_i - 1 } }
    next
  end

  if line.include?('map')
    transformation = line.scan(/(\w+)-to-(\w+)/)[0]
    transformation_from = transformation[0].to_s.to_sym
    transformation_to = transformation[1].to_s.to_sym
  end

  unless (line =~ /\d/).nil?
    numbers = line.scan(/(\d+)\s(\d+)\s(\d+)/)[0]
    destination = numbers[0].to_i
    source = numbers[1].to_i
    length = numbers[2].to_i
    s_start = source
    s_end = source + length - 1
    new_from = []
    items[transformation_from].each do |r|
      if s_start < r[:end] && s_end > r[:start]
        shift = destination - source
        items[transformation_to].push({ start: [s_start, r[:start]].max + shift, end: [s_end, r[:end]].min + shift })
        if r[:start] < s_start
          new_from.push({
                          start: r[:start],
                          end: s_start
                        })
        end
        if r[:end] > s_end
          new_from.push({
                          start: s_end,
                          end: r[:end]
                        })
        end
      else
        new_from.push(r)
      end
    end
    items[transformation_from] = new_from
  end

  if line.sub(/\n/, '').empty? && !transformation_from.empty?
    items[transformation_to].concat(items[transformation_from])
  end

  # ap line
  # ap({ from: items[transformation_from], to: items[transformation_to] })
end

ap items
ap items[:location].map { |i| i[:start] }.min
