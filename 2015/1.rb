#!/usr/bin/env ruby

values = {
  '(' => 1,
  ')' => -1,
}

puts STDIN.read.split(//).map{|c| values[c].to_i }.reduce(:+)
