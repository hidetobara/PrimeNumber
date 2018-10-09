import time
from multiprocessing import Process, Array

def run():
	start = time.time()
	max = 120000
	primes = Array('i', range(max))

	p0 = Process(target=worker, args=(primes,2,max))
	p0.start()
	p1 = Process(target=worker, args=(primes,3,max))
	p1.start()
	p2 = Process(target=worker, args=(primes,4,max))
	p2.start()
	p3 = Process(target=worker, args=(primes,5,max))
	p3.start()
	p0.join()
	p1.join()
	p2.join()
	p3.join()

	number = 0;
	for n in range(2, max, 1):
		if primes[n]: number += 1
		if number == 10000:
			print("10000th prime is " + str(n))
			break
	print("[mp.python] duration is " + str(time.time() - start) + " sec")

def worker(box, start, end):
	for n in range(start, end, 4):
		box[n] = is_prime(n)

def is_prime(number):
	for n in range(2, int(number/2)):
		if number % n == 0:
			return False
	return True

run()

