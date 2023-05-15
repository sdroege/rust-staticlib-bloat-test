use staticlib::my_staticlib_add;

fn main() {
    println!("{} + {} = {}", 1, 2, my_staticlib_add(1, 2));
}
