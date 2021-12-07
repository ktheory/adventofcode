require 'set'
entries = STDIN.read.split("\n\n")
.map{|e|
  e.split(/\s+/)
  .reduce({}) {|h, kv| k, v = kv.split(":"); h.merge(k => v)}
}

def valid?(entry)
  required = Set.new(%w(ecl pid eyr hcl byr iyr hgt))
  Set.new(entry.keys) & required == required
end

# Part 1:
puts entries.select{|e| valid?(e)}.size
