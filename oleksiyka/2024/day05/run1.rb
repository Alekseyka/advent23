rules = []
pages = []
sum = 0

File.foreach('in.txt') do |line|
  line = line.sub("\n", '')
  rules.push(line.split('|')) if line.include?('|')
  pages.push(line.split(',')) if line.include?(',')
end

pages.each do |page|
  p page
  order = true
  rules.each do |rule|
    if page.find_index(rule[0]) && page.find_index(rule[1])
      unless page.find_index(rule[0]) < page.find_index(rule[1])
        order = false
      end
    end
  end

  if order == true
    sum += page[page.length/2].to_i
  end
end

p sum
