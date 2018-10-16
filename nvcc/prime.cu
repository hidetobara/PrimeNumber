#include <stdio.h>
#include <time.h>

__global__ void kernel( int* result )
{
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	result[i] = i;
	for(int p = 2; p <= i/2; p++)
	{
		if(i % p == 0){ result[i] = 0; break; }
	}
}

double diff_sec(time_t start, time_t end)
{
	return (double)(end - start)/CLOCKS_PER_SEC;
}

int main( void )
{
	clock_t start = clock();
	const int MAX = 1024*1024;
	int *d_buffer;
	int *buffer;
	cudaMalloc((void**)&d_buffer, MAX*sizeof(int));
	buffer = new int[MAX];
	clock_t time1 = clock();

	dim3 block(512, 1, 1);
	dim3 grid(MAX/block.x, 1, 1);

	kernel<<<grid,block>>>(d_buffer);
	clock_t time2 = clock();

	cudaMemcpy(buffer, d_buffer, MAX*sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(d_buffer);
	clock_t end = clock();
	int count = 1;
	int target = 0;
	for(int i = 0; i < MAX; i++)
	{
		if(buffer[i]==0) continue;
//		printf("%d=%d\n", count, buffer[i]);
		if(count == 10000) target = buffer[i];
		count++;
	}
	printf("total=%.2f,warm-up=%.2f,gpu=%.2f,cool-down=%.2f\n", diff_sec(start,end), diff_sec(start,time1), diff_sec(time1,time2), diff_sec(time2,end));
	printf("10000th prime number is %d\n[nvcc] duration is %.2f sec\n", target, diff_sec(start,end) * 10000.0/MAX);
	return 0;
}

