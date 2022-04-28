#include <math.h>
#include <stdio.h>

inline int gcd(int x, int y) {
  while (x != 0) {
    int t = x;
    x = y % x;
    y = t;
  }
  return y;
}

inline int g(int x) {
  return x * x + 1;
}

int pollard_rho(int n, int x, int y) {
  int d = 1;
  while (d == 1) {
    x = g(x);
    y = g(g(y));
    d = gcd(abs(x - y), n);
  }
  if (d == n)
    return 0;
  else
    return d;
}
