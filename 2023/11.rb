data = STDIN.readlines.map{|l| l.strip.chars }

require 'set'

$expanded_rows = (0...data.size).select{|i| data[i].uniq == ['.']}.to_set
$expanded_cols = (0...data.first.size).select{|j| data.map{|r| r[j]}.uniq == ['.']}.to_set

galaxies = data.each_with_index.reduce([]) { |acc, (row, i)|
  row.each_with_index.reduce(acc) { |acc, (col, j)|
    acc << [i, j] if col == '#'
    acc
  }
}

# puts expanded_rows.inspect
# puts expanded_cols.inspect
# puts galaxies.inspect
def distance((x1,y1), (x2,y2), empty_factor = 1)
  x = Range.new(*[x1,x2].sort, true)
  y = Range.new(*[y1,y2].sort, true)

  x.select{|i| $expanded_rows.include?(i)}.size*empty_factor + \
  y.select{|j| $expanded_cols.include?(j)}.size*empty_factor + \
  x.size + y.size
end


puts galaxies.combination(2).map{|a,b |
  # puts "#{a} #{b} #{distance(a,b)}"
  distance(a,b)
}.sum

# Part 2:
puts galaxies.combination(2).map{|a,b |
  # 649863639480 -- too high
  distance(a,b, 1_000_000-1)
}.sum
