import time

def run():
    start = time.clock()
    primes = []
    number = 1
    while True:
        number += 1
        if not is_prime(number):
            continue
        primes.append(number)
        if len(primes) == 10000:
            print("10000th prime is " + str(number))
            break
    print("[python] duration is " + str(time.clock() - start) + " sec")

def is_prime(number):
    for n in range(2, int(number/2)):
        if number % n == 0:
            return False
    return True

run()
