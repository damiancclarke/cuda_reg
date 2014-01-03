#include <stdio.h>

#define N 512

__global__ void add(int *a, int *b, int *c) {
  c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}


int main(void) {
  int *a,*b,*c;
  int *dev_a, *dev_b, *dev_c;
  int size = N * sizeof(int);

  cudaMalloc( (void**)&dev_a, size);
  cudaMalloc( (void**)&dev_b, size);
  cudaMalloc( (void**)&dev_c, size);

  a = (int*)malloc(size);
  b = (int*)malloc(size);
  c = (int*)malloc(size);

  random_ints(a, N);
  random_ints(b, N);

  cudaMemcpy( dev_a, a, size, cudaMemcpyHostToDevice );
  cudaMemcpy( dev_b, b, size, cudaMemcpyHostToDevice );

  
  add<<<N,1>>> (dev_a,dev_b,dev_c);

  cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost );

  free(a); free(b); free(c);
  cudaFree( dev_a );
  cudaFree( dev_b );
  cudaFree( dev_c );

  return 0;
}

void random_ints(int* a, int N)
{
  int i;
  for (i = 0; i < N; ++i)
    a[i] = rand();
}
