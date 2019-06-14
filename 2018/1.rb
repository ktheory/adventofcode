lines = STDIN.readlines
# Part 1
puts lines.map(&:to_i).reduce(:+)

# Part 2
require 'set'
s = Set.new << 0
sum = 0
lines.map(&:to_i)
  .cycle
  .detect{|i|
    sum += i
    if s.include? sum
      sum
    else
      s << sum
      false
    end
  }
puts sum