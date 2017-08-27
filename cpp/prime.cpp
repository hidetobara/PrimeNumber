#include<stdio.h>
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
	clock_t start = clock();
	int list[10000];
	int count = 0;
	for(int number = 2; ; number++)
	{
		if(!isPrime(number)) continue;
		list[count] = number;
		count++;
		if(count == 10000)
		{
			printf("10000th prime is %d\n", number);
			break;
		}
	}
	printf("duration is %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}
