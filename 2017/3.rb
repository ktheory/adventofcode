data = STDIN.read.to_i

def odd_square(i)
  ((i*2) + 1) ** 2
end

# figure out which ring you're on, noticing the bottom right
# numbers are odd squares.
# 1000 is a big enough number to exceed input
ring = (0..1000).detect{|i| odd_square(i) >= data }

# the minimum numbers on the ring where it's `ring` distance to origin
mins = [1, 3, 5, 7].map{|i| odd_square(ring) - (ring*i) }

# offset = how many additional steps to take to get to the min
offset = mins.map{|min| (min - data).abs}.min

puts ring + offset

# Part 2: see https://oeis.org/A141481
