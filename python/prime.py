import time
import sys

def run():
    limit = 10000
    if len(sys.argv) == 2: limit = int(sys.argv[1])

    start = time.clock()
    count = 0;
    number = 1
    while True:
        number += 1
        if not is_prime(number):
            continue
        count += 1
        if count == limit:
            print(str(limit) + "th prime is " + str(number))
            break
    print("[python] duration is " + str(time.clock() - start) + " sec")

def is_prime(number):
    for n in range(2, int(number/2)+1):
        if number % n == 0:
            return False
    return True

run()
