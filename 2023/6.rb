raw = STDIN.readlines
times, distances = raw.map{|l| l.split(':').last.split(/\s+/).select{|c| c.size > 0 }.map(&:to_i)}
data = times.zip(distances)#.map{|t, d| {time: t, distance: d}}

# puts data.inspect

# Part 1
puts data.map{ |time, distance|
  (1..time).select{|i| i * (time - i) > distance}.size
}.reduce(&:*)

# Part 2
time, distance = raw.map{|l| l.gsub(/\D/, '').to_i}
puts (1..time).select{|i| i * (time - i) > distance}.size

