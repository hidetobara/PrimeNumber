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

int main( void )
{
	clock_t start = clock();
	const int MAX = 1024*1024;
	int *d_buffer;
	int *buffer;
	cudaMalloc((void**)&d_buffer, MAX*sizeof(int));
	buffer = new int[MAX];

	dim3 block(512, 1, 1);
	dim3 grid(MAX/block.x, 1, 1);

	kernel<<<grid,block>>>(d_buffer);
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
	printf("total=%.2f\n", (double)(end-start)/CLOCKS_PER_SEC);
	printf("10000th prime number is %d : %.2f sec\n", target, (double)(end-start)/CLOCKS_PER_SEC * 10000.0/count);
	return 0;
}

