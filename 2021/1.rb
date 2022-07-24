#!/usr/bin/env ruby

data = STDIN.readlines.map(&:to_i)

# Part 1
result = data
  .zip(data.rotate)
  .map {|a,b| b - a}
  .slice(0..-2)
  .select{|a| a > 0}
  .size

puts result

# Part 2

d2 = [nil] + data
d3 = [nil] + d2

result = (data).zip(data.rotate, data.rotate(2))
  .map{|a,b,c| a.to_i + b.to_i + c.to_i}
  .slice(0..-3)

puts result.inspect
