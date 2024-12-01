require 'pry'
require 'awesome_print'


class PartNumber
  attr_accessor :index_l
  attr_accessor :index_r
  attr_accessor :line
  attr_accessor :val
  attr_accessor :valid
  def initialize(val, index, line)
    @index_l = index
    @index_r = index + val.to_s.length - 1
    @line = line
    @val = val
    @valid = false
    @gear = []
  end

  def set_gear(x,y)
    @gear[x, y]
  end
end

class Gear
  attr_accessor :index
  attr_accessor :line
  def initialize(index, line, parts = [])
    @line = line
    @index = index
    @parts = parts
  end
end

class Solution
  def initialize(filename)
    @file = nil
    @data = nil
    @result1 = 0
    @result2 = 0

    @filename = filename
    @parts = []
    @gears = []
    @good_parts = []

    # @chars = %w[# $ % & * + - / = @]
    @chars = %w[*]

    read_input
    parse_input

    # ap @data
    # ap @parts
  end

  def scan_parts
    @data.each_with_index do |line, idx|
      next if line.nil?
      line.scan /\d+/ do |val|
        @parts << PartNumber.new(val, $~.offset(0)[0], idx)
      end
    end
  end

  def scan_gears
    @data.each_with_index do |line, idx|
      next if line.nil?
      line.scan /\*/ do |val|
        # ap line
        @gears << Gear.new($~.offset(0)[0],idx)
        # @parts << PartNumber.new(val, $~.offset(0)[0], idx)
      end
    end
  end

  def validate_parts
    @parts.each do |part|
      if validate_left(part) || validate_right(part) || validate_top(part) || validate_bottom(part)
        @result1 += part.val.to_i
      end
    end
  end

  def validate_left(part)
    @chars.include?(@data[part.line][part.index_l - 1])
  end
  def validate_right(part)
    @chars.include?(@data[part.line][part.index_r + 1])
  end
  def validate_top(part)
    return if part.line == 0
    l = part.index_l - 1 <= 0 ? 0 : part.index_l - 1
    r = part.index_r + 1 >= @data[0].length - 1 ? @data[0].length - 1 : part.index_r + 1

    substr = @data[part.line - 1][l..r]
    substr.scan(Regexp.union(@chars)).any?
  end
  def validate_bottom(part)
    return if part.line == @data.length - 1
    l = part.index_l - 1 <= 0 ? 0 : part.index_l - 1
    r = part.index_r + 1 >= @data[0].length - 1 ? @data[0].length - 1 : part.index_r + 1

    substr = @data[part.line + 1][l..r]
    substr.scan(Regexp.union(@chars)).any?
  end

  def task1
    scan_parts
    validate_parts

    ap @parts
    ap @data
    ap @chars
    @result1
  end

  def scan_parts_line(line)
    res = []
    line.scan /\d+/ do |val|
      l = $~.offset(0)[0]
      r = l + val.length - 1
      res << [val, l, r]
    end
    res
  end
  def scan_gear_parts(gear)
    ap gear
    line = gear.line
    index = gear.index
    parts = []

    prev_line = line-1 >= 0 ? @data[line-1] : ""
    next_line = line+1 <= @data.length ? @data[line+1] : ""

    puts prev_line
    puts @data[line]
    puts next_line
    puts

    prev_parts = scan_parts_line(prev_line)
    current_parts = scan_parts_line(@data[line])
    next_parts = scan_parts_line(next_line)

    current_parts.each do |p|
      l = p[1]
      r = p[2]
      parts << p if 1 == gear.index - r
      parts << p if 1 == l - gear.index
    end

    prev_parts.each do |p|
      l = p[1]
      r = p[2]
      parts << p if ((gear.index - r).abs <= 1 || (gear.index - l).abs <= 1)
    end

    next_parts.each do |p|
      l = p[1]
      r = p[2]
      parts << p if ((gear.index - r).abs <= 1 || (gear.index - l).abs <= 1)
    end

    if parts.length == 2
      @good_parts << parts.first[0].to_i * parts.last[0].to_i
    end

    @good_parts

    # exit

    # ap scan_parts_line(@data[line])
  end

  def task2
    scan_gears
    @gears.each do |gear|
      scan_gear_parts(gear)
    end
    @result2 = @good_parts.sum()
  end

  private

  def read_input
    @file = File.read(@filename)
  end

  def parse_input
    @data = @file.lines.to_a
    @data.map! { |el| el.strip! }
  end
end

def print_results(inst)
  puts
  puts '----------------------------------'
  # ap 'task1: '
  # ap inst.task1
  ap 'task2: '
  ap inst.task2
end

solution = Solution.new('input.txt')
print_results(solution)