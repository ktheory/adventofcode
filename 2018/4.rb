data = STDIN.readlines.sort

class ShiftParser
  DATE = /^\[(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2}) (?<hour>\d{2}):(?<minute>\d{2})\]/
  NEW_SHIFT = /Guard #(?<guard_id>\d+) begins shift/
  FALLS_ASLEEP = /falls asleep/
  WAKES_UP = /wakes up/

  attr_reader :line
  def initialize(line)
    @line = line
  end

  def parse(acc)
    case line
    when NEW_SHIFT
      acc.merge(guard: $~.named_captures['guard_id'], start: nil)
    when FALLS_ASLEEP
      acc.merge(start: line.match(DATE).named_captures['minute'].to_i)
    when WAKES_UP
      stop = line.match(DATE).named_captures['minute'].to_i
      acc[:shifts] << {acc[:guard] => (acc[:start]...stop)}
      acc
    end
  end
end

#data.each{|l| ShiftParser.new(l)}

raw_shifts = data.reduce({guard: nil, start: nil, shifts: []}) {|acc, line| ShiftParser.new(line).parse(acc)}[:shifts]

shifts = raw_shifts.reduce({}) {|h, shift|
  shift.reduce(h) {|h2, (k,v)| h2[k] ||= []; h2[k] << v; h2}
}

# Part 2
max_guard = shifts.map{|(g, ranges)| [g, ranges.map(&:size).sum] }
  .reduce {|max, cur| max.last > cur.last ? max : cur }.first
puts max_guard.inspect

puts max_minute = shifts[max_guard].flat_map(&:to_a).group_by{|x| x}
  .values.sort_by(&:size).last.first
  .inspect

part1 = max_minute.to_i * max_guard.to_i
puts part1

# Part 2
guard, minute, count = shifts.reduce([0,0,0]) {|acc, (g, ranges)|
  max_minutes = ranges.flat_map(&:to_a).group_by {|x| x}
    .values.max_by{|x| x.size}
  if acc.last > max_minutes.size
    acc
  else
    [g, max_minutes.first, max_minutes.size]
  end
}

puts [guard, minute, count].inspect
p2 = guard.to_i * minute.to_i
puts p2