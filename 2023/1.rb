data = STDIN.readlines

# part 1
puts data.map {|line|
  digits = line.split('').select{|c| c =~ /\d/}
  [digits.first, digits.last].join.to_i
}.sum

# part 2
def word2num(str)
  case str
  when 'one' then 1
  when 'two' then 2
  when 'three' then 3
  when 'four' then 4
  when 'five' then 5
  when 'six' then 6
  when 'seven' then 7
  when 'eight' then 8
  when 'nine' then 9
    else str.to_i
  end
end

nums = {one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven:7, eight: 8, nine: 9}.reduce({}){|h,(k,v)| h.merge(k.to_s => v)}
regexp = /(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine)/
puts data.map{|line|
  matches = line.scan(regexp)
  if false # matches.size == 1
    # 50125
    word2num matches[0][0]
  else
    # 53355
    word2num(matches[0][0]) * 10 + word2num(matches[-1][0])
  end
}.sum
