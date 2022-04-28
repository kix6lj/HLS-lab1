#include "math.h"

inline float f(float x) {
  return 9.0F * x * x + 3.0F * x - 1.0F;
}

#define EPS 1e-7F
float ternary_search(float left, float right) {
  while (fabs(right - left) >= EPS) {
    float left_third = left + (right - left) / 3.0F;
    float right_third = right - (right - left) / 3.0F;

    if (f(left_third) < f(right_third))
      right = right_third;
    else
      left = left_third;
  }
  return (left + right) / 2.0F;
}
