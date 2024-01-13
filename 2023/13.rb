# frozen_string_literal: true

data = $stdin
       .read
       .split("\n\n")
       .map { |block| block.split("\n") }

# 123456789
#     ><
# .##..##.
# ..#.##.#.
# #......#
# #......#
# ..#.##.#.
# ..##..##.
# .#.##.#.
#     ><
# 123456789
# [0,1], [1,2] -> [0,1], [1,1]
# [0,2], [2,4] -> [0,2], [2,2]
# [0,3], [3,6] -> [0,3], [3,3]
# [0,4], [4,8] -> [0,4], [4,4]
# [1,5], [5,9] -> [1,4], [5,4]
# [2,6], [6,9] -> [2,3], [6,3]

def find_horizontal(block) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  init = Set.new (1..block.first.size - 1).to_a
  block.reduce(init) do |set, row|
    puts [row, set].inspect
    set & (1..row.size - 1).select do |i|
      s1 = [0, row.size - i].max
      l1 = [i, row.size - i].min
      s2 = i
      l2 = [i, row.size - 1].min
      puts [s, i, e].inspect
      row[s, i] == row[i, e].reverse
      # XXX Figure out lengths
    end
  end
end

puts data.map { |block| find_horizontal(block) }.inspect
