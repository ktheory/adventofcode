raw_data = STDIN.read.strip

regexp = Regexp.union(('a'..'z').flat_map{|c| [c + c.upcase, c.upcase + c]})

data = raw_data.dup

while data.gsub!(regexp, '')
end

# Part 1
puts data.size

puts raw_data.size
part2 = ('a'..'z').map {|c|
  c_regexp = Regexp.union([c, c.upcase])
  d2 = raw_data.gsub(c_regexp, '')
  while d2.gsub!(regexp, '')
  end

  d2.size
}.min

puts part2.inspect