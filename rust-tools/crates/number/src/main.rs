use std::io::{self, BufRead};
use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Start numbering from 0 instead of 1
    #[arg(short = '0', long = "zero")]
    should_start_at_zero: bool,

    #[arg(short = 's', long)]
    start_from: Option<usize>,

    #[arg(short = 'b', long = "bold")]
    should_bold: bool,
}

fn main() {
    let args = Args::parse();

    let stdin = io::stdin();
    let handle = stdin.lock();

    let mut number = match args.start_from {
        Some(start_value) => start_value,
        None => if args.should_start_at_zero { 0 } else { 1 },
    };

    for line in handle.lines().map_while(Result::ok) {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            println!();
        }
        else {
            if args.should_bold {
                // using if statement instead of let if to avoid heap allocation
                println!("{number}. **{trimmed}**");
            }
            else {
                println!("{number}. {trimmed}");
            }
            number += 1;
        }
    }
}
