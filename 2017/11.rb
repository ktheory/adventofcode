data = STDIN.read.strip.split(',')

MOVES = %w(n ne se s sw nw)

def dir(idx)
  MOVES[idx % MOVES.size]
end

result = data.reduce([0, Hash.new(0)]) do |(max, acc), move|
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
  [[max, acc.values.sum].max, acc]
end

puts "Part 1: #{result.last.values.sum}"
puts "Part 2: #{result.first}"
