#include <math.h>

#define EPS 1e-7F

float mysqrt(float n) {
  float x = n/2.0F;
  float x0 = 0.0F;

  while(fabs(x - x0) < EPS) {
      x0 = x;
      x = x0/2.0F + n/(2.0F *x0);
  }
  return x0;
}
