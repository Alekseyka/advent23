
buffer = File.read('in.txt')
files = []
mode = :file
file_id = 0
buffer.chars.each do |char|
  if mode == :file
    files += [file_id.to_s] * char.to_i
    mode = :space
    file_id += 1
  else
    files += ['.'] * char.to_i
    mode = :file
  end
end

p files

ll = files.length

files.reverse.each.with_index do |char, r_index|
  next if char == '.'

  files[ll - r_index - 1] = '.'
  dot_index = files.index('.')
  files[dot_index] = char
end

sum = 0

files.each.with_index do |char, index|
  break if char == '.'
  sum += char.to_i * index
end

p files
p "SUM #{sum}"