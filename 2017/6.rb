data = STDIN.read.split(/\s+/).map(&:to_i)

require 'set'

class Bank
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def highest_index
    @highest_index ||= (0..(data.size - 1)).reduce(0) { |acc, i|
      data[i] > data[acc] ? i : acc
    }
  end

  def next_diff
     diff = Array.new(data.size) { data[highest_index] / data.size }
     (data[highest_index] % data.size).times {|i| diff[i] += 1}
     diff[-1] -= data[highest_index]
     diff.rotate!(-1 * (highest_index + 1))
     diff

  end

  def next
    Bank.new(data.zip(next_diff).map(&:sum))
  end

  def to_s
    data.join(',')
  end
end

# Part 1
states = Set.new
bank = Bank.new(data)
until states.include?(bank.to_s)
  states << bank.to_s
  bank = bank.next
end
puts states.size

# Part 2
states = []
bank = Bank.new(data)
until states.index(bank.to_s)
  states << bank.to_s
  bank = bank.next
end
puts states.size - states.index(bank.to_s)


