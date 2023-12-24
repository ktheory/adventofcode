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

# See https://web.archive.org/web/20100405070507/http://valis.cs.uiuc.edu/~sariel/research/CG/compgeom/msg00831.html

# puts vertices.inspect
pairs = vertices.each_cons(2).to_a
area = pairs.reduce(0) { |acc, ((x1,y1), (x2,y2))|
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


start = [0,0]
vertices = data.map{|line| parse2(line)}.reduce([start]){|acc, step|
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

# See https://web.archive.org/web/20100405070507/http://valis.cs.uiuc.edu/~sariel/research/CG/compgeom/msg00831.html

# puts vertices.inspect
pairs = vertices.each_cons(2).to_a
area = pairs.reduce(0) { |acc, ((x1,y1), (x2,y2))|
  acc + x1*y2 - x2*y1
} / 2

perimeter = data.map{|line| parse2(line)[:dist]}.sum / 2 + 1

puts area + perimeter

# 133125706867777
