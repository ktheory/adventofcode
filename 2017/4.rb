data = STDIN.read.split("\n")

def valid?(line)
  words = line.split(/\s+/)
  words.size == words.uniq.size
end

result = data.select{|pw| valid?(pw) }.size

puts result

# Part 2
def valid2?(line)
  words = line.split(/\s+/).map{|word| word.split('').sort.join }
  words.size == words.uniq.size
end

result = data.select{|pw| valid2?(pw) }.size
puts result
