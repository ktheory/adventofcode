#!/usr/bin/env ruby

data = STDIN.readlines.map(&:to_i)

# Part 1
require 'set'
seen = Set.new

target = 2020
# data.each{ |i|
#   if seen.include?(target-i)
#     puts "Part 1: #{i * (target-i)}"
#     break
#   else
#     seen << i
#   end
# }

## Part 2
p2 = data.combination(3).detect{|a,b,c| a+b+c == 2020}

puts p2.reduce(:*)
