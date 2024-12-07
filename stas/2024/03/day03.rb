sum1 = File.read('input.txt', chomp: true)
            .scan(/mul\(\d*\,\d*\)/)
            .map { |m| m.scan(/\d*/)
              .select { |s| !s.empty? }
              .map(&:to_i).inject(:*) }
            .inject(:+)
puts sum1

sum2 = File.read('input.txt', chomp: true)
            .lines("do()").map{|s| s.lines("don't()")}.map(&:first).join
            .scan(/mul\(\d*\,\d*\)/)
            .map { |m| m.scan(/\d*/)
              .select { |s| !s.empty? }
              .map(&:to_i).inject(:*) }
            .inject(:+)


puts sum2