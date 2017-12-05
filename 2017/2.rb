data = STDIN.read
  .split("\n")
  .map{|line| line.split(/\s+/).map(&:to_i) }

# Part 1
result = data
  .map{|line| line.max - line.min}
  .sum

puts result.inspect

# Part 2
def detect_divisors(line)
  line.sort.reverse.combination(2).to_a.detect{|a,b| a % b == 0}
end

result = data
  .map{ |line| detect_divisors(line) }
  .map{ |a, b| a / b }
  .sum

puts result.inspect
