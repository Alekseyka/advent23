threads = []

4.times do
  threads << Thread.new do
    Time.now
  end
end

threads.each(&:join)
threads.each {puts _1.value}

# pp threads