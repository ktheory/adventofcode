data = STDIN.readlines
require 'set'
class Card
  def initialize(str)
    card, res = str.split(":")
    winning, hand = res.split("|")
    # @id = card.match(/(\d+)/)[1].to_i
    @winning = Set.new(winning.strip.split(" "))
    @hand = Set.new(hand.strip.split(" "))
  end

  def wins
    @wins ||= @winning & @hand
  end

  def points
    wins.empty? ? 0 : 2**(wins.size - 1)
  end
end


puts data.map{|l| Card.new(l).points}.sum
