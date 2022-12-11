package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func sum(a []int) int {
	s := 0
	for _, i := range a {
		s += i
	}
	return s
}

func line2ints(s string) []int {
	words := strings.Split(s, "\n")

	ary := make([]int, 0)

	for _, w := range words {
		i, _ := strconv.Atoi(w)
		ary = append(ary, i)
	}

	return ary
}

func main() {
	raw, _ := os.ReadFile("1.txt")
	data := strings.Split(string(raw), "\n\n")
	// fmt.Println(len(data))

	sums := make([]int, 0)

	for _, elf := range data {
		sums = append(sums, sum(line2ints(elf)))

	}

	sort.Ints(sums)
	part1 := sums[len(sums)-1]
	fmt.Println(part1)

	part2 := sum(sums[len(sums)-3: len(sums)])
	fmt.Println(part2)
}
