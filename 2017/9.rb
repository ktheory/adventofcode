data = STDIN.read

class Parser
  attr_reader :data
  def initialize(data)
    @data = data
    @score = 0
    @level = 0
    @skip = false
    @in_garbage = false
  end

  def parse!
    (data).each_char do |c|
      if skip?
        end_skip!
        next
      end

      case c
      when '{'
        @level += 1 unless in_garbage?
      when '}'
        unless in_garbage?
          @score += @level
          @level -= 1
        end
      when '!'
        start_skip!
      when '<'
        start_garbage!
      when '>'
        end_garbage!
      end
    end

    @score
  end

  def skip?; @skip; end
  def start_skip!; @skip = true; end
  def end_skip!; @skip = false; end

  def in_garbage?; @in_garbage; end
  def start_garbage!; @in_garbage = true; end
  def end_garbage!; @in_garbage = false; end
end

puts Parser.new(data).parse!
