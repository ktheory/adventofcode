data = STDIN.read.split("\n")

REGISTERS = Hash.new(0)

class Instruction
  Ops = {
    'inc' => -> (reg, i) { REGISTERS[reg] += i },
    'dec' => -> (reg, i) { REGISTERS[reg] -= i },
    '>' =>   -> (reg, i) { REGISTERS[reg] > i },
    '>=' =>  -> (reg, i) { REGISTERS[reg] >= i },
    '<' =>   -> (reg, i) { REGISTERS[reg] < i },
    '<=' =>  -> (reg, i) { REGISTERS[reg] <= i },
    '==' =>  -> (reg, i) { REGISTERS[reg] == i },
    '!=' =>  -> (reg, i) { REGISTERS[reg] != i }
  }

  def initialize(line)
    @parts = line.split
  end

  def reg; @parts[0]; end
  def op; @parts[1]; end
  def value; @parts[2].to_i; end
  def cond_reg; @parts[4]; end
  def cond; @parts[5]; end
  def cond_value; @parts[6].to_i; end

  def process!
    if Ops[cond].call(cond_reg, cond_value)
      Ops[op].call(reg, value)
    end
  end
end

max = 0
data.each {|line|
  Instruction.new(line).process!
  max = [max, REGISTERS.values.max].max
}

# Part 1:
puts REGISTERS.values.max
puts max
