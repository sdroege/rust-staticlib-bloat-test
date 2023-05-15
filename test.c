#include <stdio.h>

extern int my_staticlib_add(int a, int b);

int main(void) {
  printf("%d + %d = %d\n", 1, 2, my_staticlib_add(1, 2));
  return 0;
}
