buffer = File.read('in.txt')
files = []
mode = :file
file_id = 0
file_ids = {}
free_spaces = []
buffer.chars.each do |char|
  if mode == :file
    files += [file_id.to_s] * char.to_i
    file_ids[file_id] = char.to_i
    mode = :space
    file_id += 1
  else
    index = files.size
    files += ['.'] * char.to_i
    mode = :file
    free_spaces.push([index, char.to_i])
  end
end

ll = files.length

# p files

files.size.times do |r_index|
  char = files[ll - r_index - 1]
  next if char == '.'

  file_len = file_ids[char.to_i]
  the_index = -1
  the_fs_index = -1
  the_diff = -1
  free_spaces.each.with_index do |free_space, fs_index|
    index = free_space[0]
    len = free_space[1]
    if len >= file_len
      the_index = index
      the_diff = len - file_len
      the_fs_index = fs_index
      break
    end
  end

  next if (ll - r_index - 1) < the_index
  next if the_index == -1

  file_len.times do |n|
    files[ll - r_index - 1 - n] = '.'
    files[the_index + n] = char
  end

  if the_diff == 0
    free_spaces.delete_at(the_fs_index)
  else
    free_spaces[the_fs_index] = [the_index + file_len, the_diff]
  end

  # p files.join
end

sum = 0

files.each.with_index do |char, index|
  next if char == '.'
  sum += char.to_i * index
end

# p files
p "SUM #{sum}"