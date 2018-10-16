package main

import (
	"fmt"
	"time"
)

func main() {
	const limit = 10000
	start := time.Now()
	primes := []int{}
	for n := 2; ; n++ {
		if !isPrime(n) {
			continue
		}
		primes = append(primes, n)
		//fmt.Printf("%d\n", n)
		if len(primes) == limit {
			fmt.Printf("%dth prime is %d\n", limit, n)
			break
		}
	}
	duration := time.Now().Sub(start)
	fmt.Printf("[go] duration=%d msec\n", duration.Nanoseconds() / (1000*1000))
}

func isPrime(number int) bool {
	for n := 2; n < number / 2; n++ {
		if number % n == 0 {
			return false
		}
	}
	return true
}
