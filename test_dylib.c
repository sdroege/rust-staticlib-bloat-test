extern int my_staticlib_add(int a, int b);

int my_dylib_add(int a, int b) {
  return my_staticlib_add(a, b);
}
