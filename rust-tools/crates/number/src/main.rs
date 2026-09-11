use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();

    for line in stdin.lines().map_while(Result::ok) {
        println!("{line}")
    }
}
