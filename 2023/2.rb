class Game
  attr_reader :id, :draws

  def initialize(str)
    @id = str.match(/Game (\d+):/)[1].to_i
    @draws = str.split(':')[1]
      .split(';').map{|g|
         g.split(',').map{|c|
           c.match(/(?<count>\d+) (?<color>\w+)/)}.reduce({}) {|h, m|
             h.merge(m['color' ] => m['count'].to_i)
          }
        }
  end

  def part1_valid?
    @draws.all?{|h|
      h['red'].to_i <= 12 && h['green'].to_i <= 13 && h['blue'].to_i <= 14
    }
  end

  def part2_min
    @draws.reduce({'red' => 0, 'green' => 0, 'blue' => 0}) {|h, draw|
      h.merge({
        'red' =>   [h['red'], draw['red'].to_i].max,
        'blue' =>  [h['blue'], draw['blue'].to_i].max,
        'green' => [h['green'], draw['green'].to_i].max
      })
  }
  end

  def part2_power
    part2_min.values.reduce(:*)
  end
end

data = STDIN.readlines.map{|l| Game.new(l)}
puts data.map{|g| g.part1_valid? ? g.id : 0}.sum

# 1296173 is too high
puts data.map{|g| g.part2_power}.sum
# puts data.map{|g| g.part2_min}.inspect
