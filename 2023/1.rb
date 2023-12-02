data = STDIN.readlines

# part 1
puts data.map {|line|
  digits = line.split('').select{|c| c =~ /\d/}
  [digits.first, digits.last].join.to_i
}.sum

# part 2

nums = {one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven:7, eight: 8, nine: 9}

regexps = nums.keys + (1..9).to_a
puts data.map{|line|
  regexps.map{|v| line.match(/#{v}/)}
  .compact
  .sort{|a,b| a.begin(0) <=> b.begin(0)}
  .values_at(0,-1)
  .map{|m| nums.key?(m[0].to_sym) ? nums[m[0].to_sym].to_s : m[0].to_s}.join.to_i
}.sum
