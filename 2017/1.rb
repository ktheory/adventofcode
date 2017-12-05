#!/usr/bin/env ruby

data = STDIN.read
  .chomp
  .split('')
  .map(&:to_i)

result = (0..data.size).reduce(0) {|sum, i| data[i] == data[(i+1) % data.size] ? sum + data[i] : sum }
puts result


puts (0..data.size).reduce(0) {|sum, i| data[i] == data[(i+ data.size/2) % data.size] ? sum + data[i] : sum }
