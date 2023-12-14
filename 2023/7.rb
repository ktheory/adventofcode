data = STDIN.read.split("\n").map{|l| hand, bet = l.split(" "); [hand, bet.to_i]}

class Hand
  attr_reader :hand, :bet
  def initialize(hand:, bet:)
    @hand = hand
    @bet = bet
  end

  def to_s
    "Hand<#{@hand} #{@bet}>"
  end

  def hand_rank
    @hand_rank ||= case @hand.chars.group_by(&:itself).values.map(&:size).sort.reverse
      when [5] then 7
      when [4,1] then 6
      when [3,2] then 5
      when [3,1,1] then 4
      when [2,2,1] then 3
      when [2,1,1,1] then 2
      else 1
    end
  end

  def card_rank(i)
    case i
      when 'A' then 14
      when 'K' then 13
      when 'Q' then 12
      when 'J' then 11
      when 'T' then 10
      else i.to_i
    end
  end

  def rank
    [hand_rank] + @hand.chars.map{|c| card_rank(c)}
  end

  def <=>(other)
    rank <=> other.rank
  end
end

# puts data.map{|hand, bet| Hand.new(hand: hand, bet: bet)}.sort.map{|h| h.rank}.sort.inspect

puts data.map{|hand, bet| Hand.new(hand: hand, bet: bet)}.sort.map.with_index(1){|h, i| h.bet * i}.sum


class Hand2
  attr_reader :hand, :bet
  def initialize(hand:, bet:)
    @hand = hand
    @bet = bet
  end

  def to_s
    "Hand<#{@hand} #{@bet}>"
  end

  def hand_rank
    counts = @hand.chars.select{|c| c != 'J' }.group_by(&:itself).values.map(&:size).sort.reverse
    counts[0] ||= 0
    counts[0] += jokers
    case counts
      when [5] then 7
      when [4,1] then 6
      when [3,2] then 5
      when [3,1,1] then 4
      when [2,2,1] then 3
      when [2,1,1,1] then 2
      else 1
    end
  end

  def card_rank(i)
    case i
      when 'A' then 14
      when 'K' then 13
      when 'Q' then 12
      when 'J' then -1
      when 'T' then 10
      else i.to_i
    end
  end

  def jokers
    @jokers ||= @hand.chars.select{|c| c == 'J' }.size
  end

  def rank
    [hand_rank] + @hand.chars.map{|c| card_rank(c)}
  end

  def <=>(other)
    rank <=> other.rank
  end
end


puts data.map{|hand, bet| Hand2.new(hand: hand, bet: bet)}.sort.map.with_index(1){|h, i| h.bet * i}.sum
