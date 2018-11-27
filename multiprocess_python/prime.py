import time
import sys
from multiprocessing import Process, Array

def run():
	STEP = 10000

	limit = 10000
	if len(sys.argv) == 2: limit = int(sys.argv[1])

	start = time.time()
	count = 0
	number = 2	
	primes = Array('i', range(STEP))
	while True:
		p0 = Process(target=worker, args=(primes,number+0,number+STEP,number))
		p0.start()
		p1 = Process(target=worker, args=(primes,number+1,number+STEP,number))
		p1.start()
		p2 = Process(target=worker, args=(primes,number+2,number+STEP,number))
		p2.start()
		p3 = Process(target=worker, args=(primes,number+3,number+STEP,number))
		p3.start()
		p0.join()
		p1.join()
		p2.join()
		p3.join()

		for s in range(0, STEP, 1):
			if not primes[s]:
				continue
			count += 1
			if count == limit:
				print(str(limit) + "th prime is " + str(number+s))
				break
		else:
			number += STEP
			continue
		break
	print("[mp.python] duration is " + str(time.time() - start) + " sec")

def worker(box, start, end, offset):
	for n in range(start, end, 4):
		box[ n - offset ] = is_prime(n)

def is_prime(number):
	for n in range(2, int(number/2)+1):
		if number % n == 0:
			return False
	return True

run()

