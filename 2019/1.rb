data = STDIN.readlines
  .map{|line| line.to_i}

def fuel(amt)
  (amt / 3) - 2
end

# part 1
part1 = data.map{|i| fuel(i) }.sum
puts part1

# part 2

def total_fuel(amt)
  next_fuel = fuel(amt.last)
  if next_fuel > 0
    total_fuel(amt + [next_fuel])
  else
    amt[1..-1].sum
  end
end

puts data.map{|i| total_fuel([i]) }.sum

# 14928564 - too high
