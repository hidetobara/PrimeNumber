#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<pthread.h>

#define WORKERS 4
#define STEP 10000

struct task_t 
{
	int start, end, step, offset;
	bool* primes;
};

bool isPrime(int number)
{
	for(int n = 2; n <= number / 2; n++)
	{
		if(number % n == 0) return false;
	}
	return true;
}

void* search(void* args)
{
	task_t* task = (task_t*)args;
	for(int n = task->start; n < task->end; n += task->step) task->primes[n - task->offset] = isPrime(n); 
}

int main(int argc, char* args[])
{
	pthread_t threads[WORKERS];
	task_t tasks[WORKERS];
	bool primes[STEP];

	int limit = 0;
	if(argc == 2) limit = atoi(args[1]);
	if(limit < 1) limit = 10000;

	int count = 0;
	time_t start = clock();
	for(int number = 2; ; number += STEP)
	{
		for(int p = 0; p < WORKERS; p++)
		{
			tasks[p].start = number + p;
			tasks[p].end = number + STEP;
			tasks[p].offset = number;
			tasks[p].step = WORKERS;
			tasks[p].primes = primes;
			pthread_create(&threads[p], NULL, search, &tasks[p]);
		}
		for(int p = 0; p < WORKERS; p++) pthread_join(threads[p], NULL);

		for(int s = 0; s < STEP; s++)
		{
			if(primes[s]) count++;
			if(count == limit)
			{
				printf("%dth prime number is %d\n", limit, number+s);
				goto end;
			}
		}
	}
	end:
	printf("[pcpp] duration is %f sec\n", (double)(clock() - start)/CLOCKS_PER_SEC);
}
