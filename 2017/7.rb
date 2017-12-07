data = STDIN.read.split("\n")
  .reduce({}) { |h, line|
    raw = line.split(/\s+/, 4)
    h.merge({raw[0] => {weight: raw[1][1..-2].to_i, above: raw[3].to_s.split(', ') }})
}

require 'set'
leaves = data.values.map{|h| h[:above]}.flatten.to_set
root = (data.keys.to_set - leaves).to_a.first
puts root

# Part 2

def weight(node, data)
  data[node][:weight] + data[node][:above].map{|n| weight(n, data) }.sum
end

def unbalanced_parent(node, data, expected = 0)
  weights =  data[node][:above].reduce({}) {|h, n|
    w = weight(n, data)
    h[w] ||= []
    h[w] << n
    h
  }

  puts weights.inspect
  if weights.values.size == 1
    # Hacks!
    raise "unbalanced: #{node}; expected #{expected - weights.keys.first * weights.values.first.size} but actually #{data[node][:weight]}"
  else
    expected_weight = weights.detect{|k,v| v.size > 1 }.first
    unbalanced = weights.values.detect{|a| a.size == 1}.first
    unbalanced_parent(unbalanced, data, expected_weight)
  end
end

puts unbalanced_parent(root, data)
