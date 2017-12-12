data = STDIN.read.strip.split(',')

MOVES = %w(n ne se s sw nw)

def dir(idx)
  MOVES[idx % MOVES.size]
end

result = data.reduce(Hash.new(0)) do |acc, move|
  i = MOVES.index(move)
  if acc[dir(i + 3)] > 0
    acc[dir(i + 3)] -= 1
  elsif acc[dir(i + 2)] > 0
    acc[dir(i + 2)] -= 1
    acc[dir(i + 1)] += 1
  elsif acc[dir(i + 4)] > 0
    acc[dir(i + 4)] -= 1
    acc[dir(i + 5)] += 1
  else
    acc[dir(i)] += 1
  end
  acc
end

puts result.values.sum

