PATH = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
PATTERN = "XMAS".split("")
matches = 0
file = File.read("input.txt", chomp: true)
array = file.split("\n").map { |s| s.split("") }
array.each_with_index do |row, row_i|
  row.each_with_index do |col, col_i|
    rose = []
    PATH.count.times do |p|
      rose[p] = []
      x = row_i
      y = col_i
      PATTERN.count.times do |i|
        rose[p] << array[x][y]
        x += PATH[p][0]
        y += PATH[p][1]
        break if x < 0 || y < 0 || x >= array.count
      end
    end
    matches += rose.select {|a| a == PATTERN}.count
  end
end
puts matches

PATH2 = [[[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]]
PATTERN2 = "MAS".split("")
matches = 0
file = File.read("input.txt", chomp: true)
array = file.split("\n").map { |s| s.split("") }
array.each_with_index do |row, row_i|
  row.each_with_index do |col, col_i|
    rose = []
    PATH2.count.times do |p|
      rose[p] = []
      PATTERN2.count.times do |i|
        x = row_i + PATH2[p][i][0]
        y = col_i + PATH2[p][i][1]
        break if x >= array.count || y>= array.first.count
        rose[p] << array[x][y]
      end
    end

    matches += 1 if (rose.include?(PATTERN2) && rose.include?(PATTERN2.reverse)) || rose.count(PATTERN2) == 2 || rose.count(PATTERN2.reverse) == 2
  end
end
puts matches