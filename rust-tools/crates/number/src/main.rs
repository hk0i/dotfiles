use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let handle = stdin.lock();
    let mut number = 1;

    for line in handle.lines().map_while(Result::ok) {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            println!();
        }
        else {
            println!("{number}. {trimmed}");
            number += 1;
        }
    }
}
