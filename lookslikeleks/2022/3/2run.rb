require 'awesome_print'

sum = 0

lines = []
index = 0

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
  lines << line

  if index == 2
    re = Regexp.new("[#{lines[0].to_s}]")
    lines[1].scan(re).uniq.each do |char|
      the_chars = lines[2].scan(Regexp.new(char)).uniq
      unless the_chars[0].nil?
        sum += the_chars[0].priority
      end
    end

    lines = []
    index = 0
  else
    index += 1
  end

end

p sum
