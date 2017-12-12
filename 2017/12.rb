data = STDIN.read.split("\n")

require 'set'

def add_pairs(hash, i, j)
  hash[i] ||= Set.new
  hash[j] ||= Set.new
  hash[i] << j
  hash[j] << i
  hash
end

def find_links(data, node, results = Set.new)
  return results if results.include?(node)
  results << node
  results | data[node].map{|n| find_links(data, n, results) }.reduce(Set.new) {|a,s| a | s}
end

pair_map = data.reduce({}) do |h, line|
  parts = line.split(/,?\s/)
  source = parts[0].to_i
  sinks = parts[2..-1].map(&:to_i)
  sinks.each {|sink| add_pairs(h, source, sink) }
  h
end

# Part 1
puts find_links(pair_map, 0).size

# Part 2
groups = 0
while pair_map.any? do
  groups += 1
  find_links(pair_map, pair_map.keys.first).each{|k| pair_map.delete(k) }
end

puts groups
