require 'awesome_print'

sum = 0
lines = []
gear_numbers = []
gear_positions = []

File.foreach('in.txt') do |line|
  line = line.sub(/\n/, '')
  lines << line
end

lines_l = lines.length - 1

lines.each.with_index do |current_line, index|
  lines[index] = current_line.gsub(/\d+/) do |found_number|
    gear_found = false
    index_start = current_line.index(found_number)
    length = found_number.length + (index_start.zero? ? 1 : 2)
    index_start -= 1 unless index_start.zero?

    lines_around = [
      index.zero? ? '' : lines[index - 1][index_start, length],
      current_line[index_start, length],
      index == lines_l ? '' : lines[index + 1][index_start, length]
    ]

    lines_around.each.with_index do |line_around, line_around_index|
      next if (gear_index = line_around.index(/[*]/)).nil?

      gear_found = true
      gear_position = "#{index + line_around_index - 1}:#{index_start + gear_index}"
      gear_numbers << { number: found_number, gear_position: }
      gear_positions << gear_position
    end

    # ap({ m: found_number, line1: lines_around[0], line2: lines_around[1], line3: lines_around[2], gear_found: })

    current_line = current_line.sub(found_number, '?' * found_number.length)
    '?' * found_number.length
  end
end

gear_positions = gear_positions.uniq

gear_positions.each do |current_gear|
  gears = gear_numbers.select { |i| i[:gear_position] == current_gear }
  next unless gears.length == 2

  sum += gears[0][:number].to_i * gears[1][:number].to_i
  ap gears
end

ap sum