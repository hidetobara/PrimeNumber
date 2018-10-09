#include<thread>
#include<stdio.h>

using namespace std;

#define LIMIT 120000

/**
 * g++49 -std=c++11 -I/usr/local/lib/gcc49/include/c++/ -Wl,-rpath=/usr/local/lib/gcc49 -pthread prime.cpp
 */

bool isPrime(int number)
{
	for(int n = 2; n < number / 2; n++)
	{
		if(number % n == 0) return false;
	}
	return true;
}

void work(bool list[], int start, int end)
{
	for(int number = start; number < end; number+=4) list[number] = isPrime(number);
}

int main(int argc, char *args[])
{
	clock_t start = clock();
	bool list[LIMIT];
	std::thread t0(work,list,2,LIMIT);
	std::thread t1(work,list,3,LIMIT);
	std::thread t2(work,list,4,LIMIT);
	std::thread t3(work,list,5,LIMIT);
	t0.join();
	t1.join();
	t2.join();
	t3.join();

	int count = 0;
	for(int n = 2; n < LIMIT; n++)
	{
		if(list[n]) count++;
		if(count == 10000)
		{
			printf("10000th prime is %d\n", n);
			break;
		}
	}
	printf("[mcpp] duration is %f sec\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}

