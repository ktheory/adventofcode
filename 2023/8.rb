data = STDIN.readlines.map{|l| l.split(' ').map(&:to_i)}

def differences(ary)
  ary.each_cons(2).map{|a, b| b - a}
end

puts data.map{|a|
  history = [a]
  while !history.last.all?{|i| i == 0} do
    history << differences(history.last)
  end
  history.map{|ary| ary.last}.sum
}.sum

# Part 2

puts data.map{|a|
  history = [a]
  while !history.last.all?{|i| i == 0} do
    history << differences(history.last)
  end

  history.map(&:first).reduce([0,0]) {|(a, i), b|
    # puts [[a,i],b].inspect
    res = i.even? ? a + b : a - b
    [res, i+1]
  }[0]
}.sum

# 19760 is too high
