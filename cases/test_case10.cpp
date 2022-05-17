/* Include polybench common header. */
#include "polybench.h"
#include <math.h>

#define M 64
#define N 64

# define _PB_M M
# define _PB_N N

#define DATA_TYPE float
#define DATA_PRINTF_MODIFIER "%0.2f "
#define SCALAR_VAL(x) x##f
#define SQRT_FUN(x) sqrtf(x)
#define EXP_FUN(x) expf(x)
#define POW_FUN(x,y) powf(x,y)


void kernel_correlation(DATA_TYPE float_n,
			DATA_TYPE POLYBENCH_2D(data,N,M,n,m),
			DATA_TYPE POLYBENCH_2D(corr,M,M,m,m),
			DATA_TYPE POLYBENCH_1D(mean,M,m),
			DATA_TYPE POLYBENCH_1D(stddev,M,m))
{
  int i, j, k;

  DATA_TYPE eps = SCALAR_VAL(0.1);


  for (j = 0; j < _PB_M; j++)
    {
      mean[j] = SCALAR_VAL(0.0);
#pragma clang loop unroll_count(8)
      for (i = 0; i < _PB_N; i++)
	mean[j] += data[i][j];
      mean[j] /= float_n;
    }


  for (j = 0; j < _PB_M; j++)
    {
      stddev[j] = SCALAR_VAL(0.0);
#pragma clang loop unroll_count(8)
      for (i = 0; i < _PB_N; i++)
	stddev[j] += (data[i][j] - mean[j]) * (data[i][j] - mean[j]);
      stddev[j] /= float_n;
      stddev[j] = SQRT_FUN(stddev[j]);
      /* The following in an inelegant but usual way to handle
         near-zero std. dev. values, which below would cause a zero-
         divide. */
      stddev[j] = stddev[j] <= eps ? SCALAR_VAL(1.0) : stddev[j];
    }

  /* Center and reduce the column vectors. */
  for (i = 0; i < _PB_N; i++)
#pragma clang loop unroll_count(8)
    for (j = 0; j < _PB_M; j++)
      {
	data[i][j] -= mean[j];
	data[i][j] /= SQRT_FUN(float_n) * stddev[j];
      }

  /* Calculate the m * m correlation matrix. */
  for (i = 0; i < _PB_M-1; i++)
    {
      corr[i][i] = SCALAR_VAL(1.0);
      for (j = i+1; j < _PB_M; j++)
	{
	  corr[i][j] = SCALAR_VAL(0.0);
#pragma clang loop unroll_count(8)
	  for (k = 0; k < _PB_N; k++)
	    corr[i][j] += (data[k][i] * data[k][j]);
	  corr[j][i] = corr[i][j];
	}
    }
  corr[_PB_M-1][_PB_M-1] = SCALAR_VAL(1.0);
}
