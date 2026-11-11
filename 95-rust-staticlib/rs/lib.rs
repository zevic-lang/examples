// Built with: rustc --crate-type staticlib -O lib.rs -o libmathrs.a
use std::ffi::CStr;
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn rs_gcd(mut a: u64, mut b: u64) -> u64 {
    while b != 0 {
        let t = a % b;
        a = b;
        b = t;
    }
    a
}

#[no_mangle]
pub extern "C" fn rs_is_prime(n: u64) -> i32 {
    if n < 2 {
        return 0;
    }
    let mut d = 2;
    while d * d <= n {
        if n % d == 0 {
            return 0;
        }
        d += 1;
    }
    1
}

#[no_mangle]
pub unsafe extern "C" fn rs_sum(p: *const i64, n: usize) -> i64 {
    std::slice::from_raw_parts(p, n).iter().sum()
}

/// 32-bit FNV-1a hash of a C string.
#[no_mangle]
pub unsafe extern "C" fn rs_fnv1a(s: *const c_char) -> u32 {
    let mut h: u32 = 0x811c9dc5;
    for b in CStr::from_ptr(s).to_bytes() {
        h ^= *b as u32;
        h = h.wrapping_mul(0x01000193);
    }
    h
}
