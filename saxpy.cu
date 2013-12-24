#include <stdio.h>


int main(void)
{
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));

  cudaMalloc(d_x, N*sizeof(float));
  cudaMalloc(d_y, N*sizeof(float));


}
