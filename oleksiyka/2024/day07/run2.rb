sum = 0

File.foreach('in.txt') do |line|
  line = line.sub("\n", '')
  operations = line.scan(/^(\d+):\s*([\d\s]+)$/)
  target = operations[0][0].to_i
  ns = operations[0][1].split(' ').map(&:to_i)

  combinations = %w[* + ||].repeated_permutation(ns.size - 1).to_a

  combinations.each do |combination|
    result = ns.first
    ns.each.with_index do |n, i|
      next if i == 0
      result += n if combination[i-1] == '+'
      result *= n if combination[i-1] == '*'
      result = "#{result}#{n}".to_i if combination[i-1] == '||'
    end

    if result == target
      sum += result
      break
    end
  end
end

p "Sum #{sum}"