# Ex: #5 @ 610,700: 25x21

parse_claim = -> (str) {
    /^#(?<id>\d+) @ (?<x>\d+),(?<y>\d+): (?<w>\d+)x(?<h>\d+)/.match(str)
    .named_captures
    .reduce({}) {|a, (k,v)| a.merge(k => v.to_i)}
}
claims = STDIN.readlines.map{|c| parse_claim.call(c)}

claim_to_points = -> (claim) {
    claim['w'].times.flat_map {|i| claim['h'].times.map{|j| [i+ claim['x'], j + claim['y']] } }
}

# Part 1
#puts claims.flat_map {|c| claim_to_points.call(c)}
  #.reduce({}) {|h, point| h[point] ||= 0; h[point] += 1; h }
  #.select{|k,v| v > 1}
  #.size

def overlap?(c1, c2)
  max_x = [c1['x'], c2['x']].max
  min_x_width = [c1['x'] + c1['w'], c2['x'] + c2['w']].min

  max_y = [c1['y'], c2['y']].max
  min_y_height = [c1['y'] + c1['h'], c2['y'] + c2['h']].min

  max_x < min_x_width && max_y < min_y_height
end

tmp = ['#1 @ 1,3: 4x4', '#2 @ 3,1: 4x4', '#3 @ 5,5: 2x2']
  .map{|str| parse_claim.call(str)}

puts overlap?(tmp[1], tmp[2])


# Part 2
puts tmp.reject{|c| tmp.any?{|c2| c2 != c && overlap?(c, c2)}}.inspect
puts claims.reject{|c| claims.any?{|c2| c2 != c && overlap?(c, c2)}}