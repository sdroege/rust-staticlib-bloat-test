all: my_staticlib_test libmy_staticlib_test_dylib.so libstaticlib.so my_test

my_staticlib_test: test.c libstaticlib.a
	gcc -o my_staticlib_test test.c -Wall -g -O2 libstaticlib.a

libmy_staticlib_test_dylib.so: test_dylib.c libstaticlib.a
	gcc -o libmy_staticlib_test_dylib.so -shared test_dylib.c -Wall -g -O2 libstaticlib.a

libstaticlib.so: lib.rs
	rustc --crate-type cdylib --edition=2018 -C opt-level=2 -g -C debug-assertions=on --crate-name staticlib --emit link -C panic=abort -C embed-bitcode=no -o libstaticlib.so lib.rs

libstaticlib.a: lib.rs
	rustc --crate-type staticlib --edition=2018 -C opt-level=2 -g -C debug-assertions=on --crate-name staticlib --emit link -C panic=abort -C embed-bitcode=no -o libstaticlib.a lib.rs

libstaticlib.rlib: lib.rs
	rustc --crate-type rlib --edition=2018 -C opt-level=2 -g -C debug-assertions=on --crate-name staticlib --emit link -C panic=abort -C embed-bitcode=no -o libstaticlib.rlib lib.rs

my_test: libstaticlib.rlib test.rs
	rustc --crate-type bin --edition=2018 -C opt-level=2 -g -C debug-assertions=on -C panic=abort -C embed-bitcode=no -o my_test test.rs --extern staticlib=libstaticlib.rlib

clean:
	rm -f libstaticlib.a
	rm -f libstaticlib.rlib
	rm -f libstaticlib.so
	rm -f my_test
	rm -f my_staticlib_test
	rm -f libmy_staticlib_test_dylib.so

.PHONY: all clean
.NOTPARALLEL:
