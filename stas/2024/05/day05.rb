file = File.read('input.txt', chomp: true).split("\n\n")
rules = file[0].split("\n").map { |e| e.split("|").map(&:to_i)}
sequences = file[1].split("\n").map { |e| e.split(",").map(&:to_i)}

manuals = []
sequences.each do |seq|
  pages = []
  seq.each_cons(2) do |pair|
    pages << rules.select {|rule| rule == pair}.any?
  end
  manuals << pages
end

result = 0
wrong_sequenses = []
manuals.each_with_index do |man, i|
  if man.all?
    result += sequences[i][(sequences[i].count / 2)]
  else
    wrong_sequenses << sequences[i]
  end
end
puts result

def sorter(rules, a, b)
  return -1 if rules.include?([a, b])
  return 1 if rules.include?([b, a])
  nil
end

result = 0
wrong_sequenses.each do |seq|
  sorted = seq.sort { |a, b| sorter(rules, a, b) }
  result += sorted[(sorted.count / 2)]
end

puts result