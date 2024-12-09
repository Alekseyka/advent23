@rules = []
pages = []
sum = 0

def compare(x,y)
  if @rules.find_index([x,y]) != nil
    return -1
  end
  if @rules.find_index([y,x]) != nil
    return 1
  end
  nil
end

File.foreach('in.txt') do |line|
  line = line.sub("\n", '')
  @rules.push(line.split('|')) if line.include?('|')
  pages.push(line.split(',')) if line.include?(',')
end

pages.each do |page|

  new_page = page.sort do |x,y|
    compare(x,y)
  end

  if new_page != page
    sum += new_page[new_page.length/2].to_i
  end
end

p sum
