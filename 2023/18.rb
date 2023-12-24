data = STDIN.readlines

def parse(line)
  match = line.match(/^(?<dir>\w) (?<dist>\d+) \(\#(?<color>\w{6})\)/)
  raise "Bad line: #{line}" unless match
  {dir: match[:dir], dist: match[:dist].to_i, color: match[:color]}
end

start = [0,0]
vertices = data.map{|line| parse(line)}.reduce([start]){|acc, step|
  last = acc.last
  case step[:dir]
  when 'U'
    acc + [[last[0], last[1]-step[:dist]]]
  when 'D'
    acc + [[last[0], last[1]+step[:dist]]]
  when 'L'
    acc + [[last[0]-step[:dist], last[1]]]
  when 'R'
    acc + [[last[0]+step[:dist], last[1]]]
  else
    raise "Bad direction: #{step[:dir]}"
  end
}

all_points = data.map{|line| parse(line)}.reduce([start]){|acc, step|
  last = acc.last
  case step[:dir]
  when 'U'
    acc + (1..step[:dist]).map{|i| [last[0], last[1]-i]}
  when 'D'
    acc + (1..step[:dist]).map{|i| [last[0], last[1]+i]}
  when 'L'
    acc + (1..step[:dist]).map{|i| [last[0]-i, last[1]]}
  when 'R'
    acc + (1..step[:dist]).map{|i| [last[0]+i, last[1]]}
  else
    raise "Bad direction: #{step[:dir]}"
  end
}

min_y = all_points.map{|y,x| y}.min
min_x = all_points.map{|y,x| x}.min
coords = all_points.reduce([]){|acc, (y,x)|
  acc[x - min_x] ||= []
  acc[x - min_x][y - min_y] = true
  acc
}
# puts coords.map{|row| row.map{|cell| cell ? '#' : '.'}.join}.join("\n")

volume = coords.map {|row|
  res = row.reduce({count: 0, inside: false, prior: false, out: ''}){|acc, cell|
    if cell
      acc[:out] << '#'
      acc[:count] += 1
      acc[:inside] = ! acc[:inside] unless acc[:prior]
    elsif acc[:inside]
      acc[:out] << '#'
      acc[:count] += 1
    else
      acc[:out] << '.'
    end
    acc.merge(prior: cell)
    }
    # puts res[:out]

    res[:count]
  }.sum

# puts all_points.inspect
# puts coords.inspect
# puts volume

# 103067 is too low

# See https://web.archive.org/web/20100405070507/http://valis.cs.uiuc.edu/~sariel/research/CG/compgeom/msg00831.html

# puts vertices.inspect
pairs = vertices.each_cons(2).to_a
puts pairs.inspect
area = pairs.reduce(0) { |acc, ((x1,y1), (x2,y2))|
  puts "(#{x1}, #{y1}) (#{x2}, #{y2})"
  acc + x1*y2 - x2*y1
} / 2

perimeter = data.map{|line| parse(line)[:dist]}.sum / 2 + 1

puts area + perimeter

# 108909

# Part 2
def parse2(line)
  dir_map = ['R', 'D', 'L', 'U']
  match = line.match(/\(\#(?<dist>\w{5})(?<dir>\w)\)/)
  raise "Bad line: #{line}" unless match
  {dir: dir_map[match[:dir].to_i], dist: match[:dist].hex}
end
