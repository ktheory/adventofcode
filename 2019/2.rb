data = File.read("2.txt").split(",").map(&:to_i)
# data = [1,0,0,0,99]
# data = [1,1,1,4,99,5,6,0,99]
# data = [2,4,4,5,99,0]
# data = []

# puts data.inspect
computer = -> (noun, verb, data) {
# 🙄
data[1] = noun
data[2] = verb

i = 0
while i < data.length do
  if data[i] == 99
    break
  elsif data[i] == 1
    data[data[i+3]] = data[data[i+1]] + data[data[i+2]]
  else
    data[data[i+3]] = data[data[i+1]] * data[data[i+2]]
  end
  i += 4
end

data[0]
}

# puts data.inspect

# 520625 is too low
# 3760627 = correct
puts computer.call(12, 2, data.dup)

# Part 2
noun, verb = (0..99).to_a.repeated_permutation(2).detect{|(n,v)| computer.call(n, v, data.dup) == 19690720}

puts(100 * noun + verb)
