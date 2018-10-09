import time
from threading import Thread

def run():
	start = time.clock()
	primes = {}
	max = 120000

	t0 = Thread(target=worker, args=(primes,2,max))
	t0.start()
	t1 = Thread(target=worker, args=(primes,3,max))
	t1.start()
	t2 = Thread(target=worker, args=(primes,4,max))
	t2.start()
	t3 = Thread(target=worker, args=(primes,5,max))
	t3.start()
	t0.join()
	t1.join()
	t2.join()
	t3.join()

	number = 0;
	for n in range(2, max, 1):
		if primes[n]: number += 1
		if number == 10000:
			print("10000th prime is " + str(n))
			break
	print("[mt.python] duration is " + str(time.clock() - start) + " sec")

def worker(box, start, end):
	for n in range(start, end, 4):
		box[n] = is_prime(n)

def is_prime(number):
	for n in range(2, int(number/2)):
		if number % n == 0:
			return False
	return True

run()

