#include<thread>
#include<stdio.h>

using namespace std;

#define STEP  10000

/**
 * g++ -std=c++11 -I/usr/local/lib/gcc49/include/c++/ -Wl,-rpath=/usr/local/lib/gcc49 -pthread prime.cpp
 */

bool isPrime(int number)
{
	for(int n = 2; n <= number / 2; n++)
	{
		if(number % n == 0) return false;
	}
	return true;
}

void work(bool list[], int start, int end, int offset)
{
	for(int number = start; number < end; number+=4) list[number-offset] = isPrime(number);
}

int main(int argc, char *args[])
{
	int limit = 0;
	if(argc == 2) limit = atoi(args[1]);
	if(limit < 1) limit = 10000;

	clock_t start = clock();
	int count = 0;
	for(int number = 2; ; number += STEP)
	{
		bool list[STEP];
		std::thread t0(work,list,number+0,number+STEP,number);
		std::thread t1(work,list,number+1,number+STEP,number);
		std::thread t2(work,list,number+2,number+STEP,number);
		std::thread t3(work,list,number+3,number+STEP,number);
		std::this_thread::sleep_for(std::chrono::microseconds(1));
		t0.join();
		t1.join();
		t2.join();
		t3.join();

		for(int s = 0; s < STEP; s++)
		{
			if(list[s]) count++;
			if(count == limit)
			{
				printf("%dth prime is %d\n", limit, number+s);
				goto end;
			}
		}
	}
	end:
	printf("[mcpp] duration is %f sec\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}

