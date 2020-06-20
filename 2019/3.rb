wires = File.read("3.txt").split("\n").map{|wire| wire.split(",")}

# wires = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"].map{|l| l.split(",")}

trace = -> (steps) {
  steps.reduce([[0,0]]) {|pts, step|
    dir = step[0]
    magnitude = step[1..-1].to_i
    x,y = pts.last

    pts + case dir
    when "U"
      magnitude.times.map{|i| [x, y+1+i]}
    when "D"
      magnitude.times.map{|i| [x, y-(1+i)]}
    when "R"
      magnitude.times.map{|i| [x+(1+i),y]}
    when "L"
      magnitude.times.map{|i| [x-(1+i),y]}
    end
  }
}

traces = wires.map{|w| trace.call(w)}

p1 = traces
  .reduce(&:&)
  .map{|pair| pair.map(&:abs).sum }
  .select{|x| x > 0}
  .sort
  .first

# 1316 is too low
# 2180 = correct
puts p1.inspect

# Part 2
p2 = traces
  .reduce(&:&)
  .map{|p| traces.map{|t| t.index(p)}.sum}
   .select{|x| x > 0}
  .sort
  .first

puts p2
