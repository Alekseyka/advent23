puts "Input:"

rules = {}

STDIN.readline(sep="\n\n").chomp.split(/\r?\n/).map{ |r| r.split('|').map(&:to_i) }.each do |r|
  rules[r[0]] ||= []
  rules[r[0]].push(r[1])
end

pages = STDIN.readline(sep="\0").chomp.split(/\r?\n/).map{ |v| v.split(',').map(&:to_i) }

def ordered(rules,pages)
  pages.each_with_index do |page, i|
    (0 ... i).each do |j| 
      return false if (rules[page] && rules[page].include?(pages[j]))
    end
  end
  true
end

def reorder(rules,pages)
  pages.each_with_index do |page, i|
    (0 ... i).each do |j| 
      if (rules[page] && rules[page].include?(pages[j]))
        tmp = pages[i]
        pages[i] = pages[j]
        pages[j] = tmp
        return
      end
    end
  end
end

middies = baddies = 0
pages.each do |page|
  if(ordered(rules,page))
    middies += page[(page.length / 2).ceil]
  else
    loops = 0
    while (!ordered(rules,page)) do
      reorder(rules,page)
    end
    baddies += page[(page.length / 2).ceil]
  end
end

puts "Sum of valid middle pages: #{middies}"
puts "Sum of fixed middle pages: #{baddies}"