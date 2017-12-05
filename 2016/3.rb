def isTriangle?(a,b,c)
  a + b > c
end

rows = STDIN.read
  .map{|line| line.split.map(&:to_i) }

puts rows.split("\n")
  .map{|row| row.sort }
  .select {|sides| isTriangle?(*sides) }
  .size
