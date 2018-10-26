#include<stdio.h>
#include<time.h>
#include<pthread.h>

#define SEARCH_LIMIT 120000
#define STEP 4

struct task_t 
{
	int start, end, step;
	bool* primes;
};

bool isPrime(int number)
{
	for(int n = 2; n < number / 2; n++)
	{
		if(number % n == 0) return false;
	}
	return true;
}

void* search(void* args)
{
	task_t* task = (task_t*)args;
	for(int n = task->start; n < task->end; n += task->step) task->primes[n] = isPrime(n); 
}

int main(int argc, char* argv[])
{
	pthread_t threads[STEP];
	task_t tasks[STEP];
	bool primes[SEARCH_LIMIT];

	time_t start = clock();
	for(int p = 0; p < STEP; p++)
	{
		tasks[p].start = p + 2;
		tasks[p].end = SEARCH_LIMIT;
		tasks[p].step = STEP;
		tasks[p].primes = primes;
		pthread_create(&threads[p], NULL, search, &tasks[p]);
	}
	for(int p = 0; p < STEP; p++) pthread_join(threads[p], NULL);

	int count = 0;
	for(int n = 2; n < SEARCH_LIMIT; n++)
	{
		if(primes[n]) count++;
		if(count == 10000)
		{
			printf("10000th prime number is %d\n", n);
			break;
		}
	}
	printf("[pcpp] duration is %f sec\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}
