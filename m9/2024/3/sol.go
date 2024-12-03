package main

import (
	"flag"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func errorHandler(err error) {
	if err != nil {
		panic(err)
	}
}
func inputFileName(testFlag *bool) string {
	if *testFlag {
		return "example.txt"
	}
	return "input.txt"
}

func main() {
	testFlag := flag.Bool("test", false, "")
	flag.Parse()

	buf, err := os.ReadFile(inputFileName(testFlag))
	errorHandler(err)

	input := string(buf)

	fmt.Printf("task1 = %d\n", sol1(input))
	fmt.Printf("task2 = %d\n", sol2(input))
}

func sol1(input string) int {

	r := regexp.MustCompile(`mul\((\d+),(\d+)\)`)
	matches := r.FindAllStringSubmatch(input, -1)

	sum := 0

	for _, v := range matches {
		a, err := strconv.Atoi(v[1])
		errorHandler(err)

		b, err := strconv.Atoi(v[2])
		errorHandler(err)

		sum = sum + a*b
	}

	return sum
}

func sol2(input string) int {

	r := regexp.MustCompile(`mul\((\d+),(\d+)\)|(do\(\))|(don't\(\))`)
	matches := r.FindAllStringSubmatch(input, -1)

	sum := 0
	flipper := true

	modifiers := map[string]bool{
		"do()":    true,
		"don't()": true,
	}
	
	for _, v := range matches {

		if modifiers[v[0]] {
			if "do()" == v[0] {
				flipper = true
				continue
			}

			if "don't()" == v[0] {
				flipper = false
				continue
			}
		}

		if flipper {
			a, err := strconv.Atoi(v[1])
			errorHandler(err)

			b, err := strconv.Atoi(v[2])
			errorHandler(err)

			sum = sum + a*b
		}
	}

	return sum
}
