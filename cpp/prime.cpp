#include<stdio.h>
#include<stdlib.h>
#include<time.h>

bool isPrime(int number)
{
	for(int n = 2; n < number / 2; n++)
	{
		if(number % n == 0) return false;
	}
	return true;
}

int main(int argc, char *args[])
{
	int limit = 0;
	if(argc == 2) limit = atoi(args[1]);
	if(limit < 1) limit = 10000;

	clock_t start = clock();
	int count = 0;
	for(int number = 2; ; number++)
	{
		if(!isPrime(number)) continue;
		count++;
		if(count == limit)
		{
			printf("%dth prime is %d\n", limit, number);
			break;
		}
	}
	printf("[cpp] duration is %f sec\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}
