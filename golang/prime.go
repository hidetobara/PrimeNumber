package main

import (
	"fmt"
	"time"
	"os"
	"strconv"
)

func main() {
	limit := 10000
	if len(os.Args) == 2 {
		limit, _ = strconv.Atoi(os.Args[1]);
	}

	start := time.Now()
	count := 0
	for n := 2; ; n++ {
		if !isPrime(n) {
			continue
		}
		count++
		if count == limit {
			fmt.Printf("%dth prime is %d\n", limit, n)
			break
		}
	}
	duration := time.Now().Sub(start)
	fmt.Printf("[go] duration=%d msec\n", duration.Nanoseconds() / (1000*1000))
}

func isPrime(number int) bool {
	for n := 2; n <= number / 2; n++ {
		if number % n == 0 {
			return false
		}
	}
	return true
}
