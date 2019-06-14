words = STDIN.readlines

to_count = -> (str) {
    str.split(//)
    .group_by {|x| x }
    .values
    .map(&:size)
    .reduce([0,0]) {|(twos, threes), i|
        if i == 2
            [twos+1, threes]
        elsif i == 3
            [twos, threes+1]
        else
            [twos, threes]
        end
    }
}

puts words.map{|w| [w, to_count.call(w)].inspect}
puts words.map{|w| to_count.call(w)}.reduce([0,0]) {|acc, ary| [acc[0] + ary[0], acc[1] + ary[1]]}
puts words.map{|w| to_count.call(w)}.reduce([0,0]) {|acc, ary| [acc[0] + [1,ary[0]].min, acc[1] + [1, ary[1]].min]}
puts words.map{|w| to_count.call(w)}.reduce([0,0]) {|acc, ary| [acc[0] + [1,ary[0]].min, acc[1] + [1, ary[1]].min]}.reduce(:*)
# 15120 is too high

# Part 2:
diff = -> (w1, w2) {
  w1.size.times.reduce(0) {|a, i| w1[i] == w2[i] ? a : a+1}
}

puts words.combination(2).detect{|words| diff.call(*words) == 1}
# krdmtuqjgwfoevnaboxglzjph