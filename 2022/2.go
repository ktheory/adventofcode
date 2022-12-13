// Abandoned--switched to rust

package main

import (
	"fmt"
	"os"
	"strings"
)

type Throw int

const (
	Rock Throw = iota
	Paper
	Scissors
)

type round struct {
	opponent Throw
	player   Throw
}

func StringToThrow(s string) (Throw, error) {
	switch {
	case s == "A" || s == "X":
		return Rock
	case s == "B" || s == "Y":
		return Paper
	case s == "C" || s == "Z":
		return Scissors
	default
	}
}

func StringToRound(s string) round {
	ary := strings.Split(s, " ")
	o, p := ary[0], ary[1]
}

func main() {
	raw, _ := os.ReadFile("2.txt")
	fmt.Println(len(raw))
}
