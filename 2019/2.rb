data = File.read("2.txt").split(",").map(&:to_i)
# data = [1,0,0,0,99]
# data = [1,1,1,4,99,5,6,0,99]
# data = [2,4,4,5,99,0]
# data = []

# puts data.inspect

# 🙄
data[1] = 12
data[2] = 2

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

puts data.inspect

# 520625 is too low
puts data[0]
