#include <stdio.h>
#include <stdlib.h>
#include <time.h>

__global__ void kernel( int* result )
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int number = result[i];
	for(int p = 2; p <= number/2; p++)
	{
		if(number % p == 0) return;
	}
	result[i] = -number;	// is prime
}

double diff_sec(time_t start, time_t end){ return (double)(end - start)/CLOCKS_PER_SEC; }

int main(int argc, char *argv[])
{
	int limit = 10000;
	if(argc == 2) limit = atoi(argv[1]);
	const int STEP = 1024*16;

	clock_t start = clock();
	int *d_buffer;
	int *buffer;
	cudaMalloc((void**)&d_buffer, STEP*sizeof(int));
	buffer = new int[STEP];
	int count = 0;
	for(int number = 2; ; number += STEP)
	{
		clock_t time0 = clock();

		for(int i = 0; i < STEP; i++) buffer[i] = number + i;
		cudaMemcpy(d_buffer, buffer, STEP*sizeof(int), cudaMemcpyHostToDevice);
		clock_t time1 = clock();

		dim3 block(512, 1, 1);
		dim3 grid(STEP/block.x, 1, 1);
		kernel<<<grid,block>>>(d_buffer);
		clock_t time2 = clock();

		cudaMemcpy(buffer, d_buffer, STEP*sizeof(int), cudaMemcpyDeviceToHost);
		clock_t time3 = clock();

		for(int i = 0; i < STEP; i++)
		{
			if(buffer[i] > 0) continue;
			count++;
//printf("\t%d", buffer[i]);
			if(count == limit)
			{
				printf("%dth prime number is %d\n", limit, -buffer[i]);
				break;
			}
		}
		printf("1=%.4f,2=%.4f,3=%.4f\n", diff_sec(time0,time1), diff_sec(time1,time2), diff_sec(time2,time3));
		if(count == limit) break;
	}

	cudaFree(d_buffer);
	clock_t end = clock();

	printf("[nvcc] duration is %.2f sec\n", diff_sec(start,end));
	return 0;
}

