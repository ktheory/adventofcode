data = STDIN.read

part1_data = data
  .split(/,\s*/)
  .map(&:to_i)

State = Struct.new(:skip_size, :cur, :list)

# Swap elements in an array
def swap(i,j, ary)
  ary[i], ary[j] = ary[j], ary[i]
  ary
end

init = State.new(0, 0, (0..255).to_a)

def reducer(s, data)
  data.reduce(s) do |state, l|
    puts state.inspect
    new_list = (l / 2).times.reduce(state.list) { |list, i|
      swap(
        (state.cur + i) % list.size,
        (state.cur + l - 1 - i) % list.size,
        list
      )
    }
    State.new(
      state.skip_size + 1,
      (state.cur + l + state.skip_size) % state.list.size,
      new_list
    )
  end
end

result = reducer(init, part1_data)
puts result.list[0,2].reduce(1) {|acc, i| acc * i}

part2_data = data.each_byte.reduce([]) {|acc, b| acc << b} + [17, 31, 73, 47, 23]

result = 64.times.reduce(init) {|state, i| reducer(state, part2_data) }
result = 16.times.reduce("") do |str, i|
  str << result.list[16*i, 16].reduce(&:^).to_s(16).rjust(2,'0')
end

# wrong: e06e5eaef3ab4e13c45608f2f1244284
puts result
