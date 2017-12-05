data = STDIN.read.split(/\s+/).map(&:to_i)

puts data.inspect

class Game
  attr_reader :pos, :steps, :state
  def initialize(pos, steps, state)
    @pos, @steps, @state = pos, steps, state
  end

  def outside?
    pos < 0 || pos >= state.size
  end

  def next
    next_pos = pos + state[pos]
    next_steps = steps + 1
    next_state = state.dup
    next_state[pos] = next_state[pos] + 1
    Game.new(next_pos, next_steps, next_state)
  end

  def next2
    next_pos = pos + state[pos]
    next_steps = steps + 1
    next_state = state#.dup
    next_state[pos] = state[pos] >= 3 ? next_state[pos] - 1 : next_state[pos] + 1
    Game.new(next_pos, next_steps, next_state)

  end
end

game = Game.new(0, 0, data)
until game.outside?
  puts "Pos: #{game.pos}, steps: #{game.steps}" if game.steps % 100 == 0
  game = game.next2
end

puts game.steps
