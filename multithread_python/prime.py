import time
import sys
from threading import Thread

def run():
	STEP = 10000

	limit = 10000
	if len(sys.argv) == 2: limit = int(sys.argv[1])

	start = time.clock()
	number = 2
	count = 0
	while True:
		primes = {}

		t0 = Thread(target=worker, args=(primes,number+0,number+STEP,number))
		t0.start()
		t1 = Thread(target=worker, args=(primes,number+1,number+STEP,number))
		t1.start()
		t2 = Thread(target=worker, args=(primes,number+2,number+STEP,number))
		t2.start()
		t3 = Thread(target=worker, args=(primes,number+3,number+STEP,number))
		t3.start()
		t0.join()
		t1.join()
		t2.join()
		t3.join()

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
	print("[mt.python] duration is " + str(time.clock() - start) + " sec")

def worker(box, start, end, offset):
	for n in range(start, end, 4):
		box[n - offset] = is_prime(n)

def is_prime(number):
	for n in range(2, int(number/2)+1):
		if number % n == 0:
			return False
	return True

run()

