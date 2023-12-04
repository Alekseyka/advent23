require 'awesome_print'

sum = 0

class String
  def priority
    ord = self[0].ord
    case ord
    when 97..122
      ord - 96
    when 65..90
      ord - 38
    end
  end
end

File.foreach('in.txt') do |line|
  line = line.sub(/\n/, '')
  ll = line.length / 2
  re = Regexp.new("[#{line[0, ll].to_s}]")
  position = (line[ll..] =~ re) + ll
  sum += line[position].to_s.priority
end

p sum
