
input = STDIN.read.chomp

puts "Part 1"
puts input
  .split("\n")
  .map{|str| str.split('')}
  .transpose
  .map { |chars| chars.group_by{|i| i}.max_by{|k,v| v.size}.first }
  .join

puts "Part 2:"
puts input
  .split("\n")
  .map{|str| str.split('')}
  .transpose
  .map { |chars| chars.group_by{|i| i}.min_by{|k,v| v.size}.first }
  .join
