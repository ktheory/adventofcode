$data = STDIN.readlines.map(&:chars)

require 'set'
$tube = Set.new

startx, starty = $data.each.with_index {|row, i|
  j = row.index('S')
  break [i, j] if j
}

def next_pos(prev, cur)
  x,y = cur

  possible_next = case $data[x][y]
  when '|'
    [ [x+1, y], [x-1, y] ]
  when '-'
    [ [x, y+1], [x, y-1] ]
  when 'L'
    [ [x-1, y], [x, y+1] ]
  when 'J'
    [ [x-1, y], [x, y-1] ]
  when '7'
    [ [x+1, y], [x, y-1] ]
  when 'F'
    [ [x+1, y], [x, y+1] ]
  else
    raise "Unknown #{x}, #{y}, #{$data[x][y]}"
  end

  possible_next.detect{|p| p != prev }
end

def loop_size(start, init_n)
  count = 0
  prev = start
  n = init_n

  $tube << prev
  $tube << n
  loop do

    # out = {count: count, prev: prev, prev_char: $data[prev.first][prev.last], n: n, n_char: $data[n.first][n.last]}
    # puts out.inspect
    break if $data[n[0]][n[1]] == 'S'

    temp_n = next_pos(prev, n)
    prev = n
    n = temp_n
    $tube << n
    count += 1

  end
  count
end

n = if %w(| J L).include? $data[startx+1][starty]
      [startx+1, starty]
    elsif %w(| 7 F).include? $data[startx-1][starty]
      [startx-1, starty]
    elsif %w(- 7 J).include? $data[startx][starty+1]
      [startx, starty+1]
    else
    # elsif %w(- L F).include? $data[startx][starty-1]
      [startx, starty-1]
     end

puts [startx, starty].inspect
puts n.inspect
c = loop_size([startx, starty], n)
puts (c+1)/2

