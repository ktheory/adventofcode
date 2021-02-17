def parse(line)
  match = line.match(/(\d+)-(\d+) (\w): (\w+)/)
  range = (match[1].to_i..match[2].to_i)
  {range: range, target: match[3], password: match[4], p1: match[1].to_i, p2: match[2].to_i}
end

def valid?(data)
  data[:range].include?(data[:password].count(data[:target]))
end

def valid2?(data)
  (data[:password][data[:p1] - 1] == data[:target]) ^ (data[:password][data[:p2] - 1] == data[:target])
end

data = STDIN.readlines

# part 1:
puts data
  .select{|l| valid?(parse(l))}
  .size

# part 2:
puts data
  .select{|l| valid2?(parse(l))}
  .size
