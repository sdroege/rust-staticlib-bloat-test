#[no_mangle]
pub extern "C" fn my_staticlib_add(left: i32, right: i32) -> i32 {
    left + right
}
