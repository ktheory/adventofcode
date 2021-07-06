def parse(line)
  line.strip.split(//)
end


def traverse(right: 3, down: 1, course:)
  course.reduce({trees: 0, x: 0, y: 0}) {|acc, line|
    puts acc.inspect
    if acc[:y] % down != 0
      acc.merge(y: acc[:y]+1)
    else
      {
        trees: line[acc[:x]] == "#" ? acc[:trees]+1 : acc[:trees],
        x: (acc[:x] + right) % line.size,
        y: acc[:y] + 1,
        char: line[acc[:x]]}
    end
  }
end

## Part 1:
course = STDIN.readlines
  .map{|l| parse(l)}

trees = traverse(course: course)[:trees]
puts trees


### Part 2

slopes = [
  {right: 1, down: 1},
  {right: 3, down: 1},
  {right: 5, down: 1},
  {right: 7, down: 1},
  {right: 1, down: 2},
]

trees = slopes.map{|s| traverse(s.merge(course: course))[:trees]}
puts trees.inspect
puts trees.reduce(1) {|a, x| a*x}

