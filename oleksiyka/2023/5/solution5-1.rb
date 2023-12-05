#!/usr/bin/env ruby

require 'awesome_print'
require 'pry'

result = 0
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
    items[:seed] = line.scan(/\d+/).map(&:to_i)
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
    to_delete = []
    items[transformation_from].each do |item|
      if item >= source && item <= (source + length - 1)
        items[transformation_to].push(destination + (item - source))
        to_delete.push(item)
      end
    end
    to_delete.each do |item|
      items[transformation_from].delete(item)
    end
  end

  if line.sub(/\n/, '').empty? && !transformation_from.empty?
    to_delete = []
    items[transformation_from].each do |item|
      items[transformation_to].push(item)
      to_delete.push(item)
    end
    to_delete.each do |item|
      items[transformation_from].delete(item)
    end
  end

  # ap line
  # ap({ from: items[transformation_from], to: items[transformation_to] })
end

ap items
ap items[:location].min
puts "Result: '#{result}'"
