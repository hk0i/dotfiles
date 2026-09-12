use std::io::{self, BufRead};
use clap::Parser;
use regex::Regex;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Start numbering from 0 instead of 1
    #[arg(short = '0', long = "zero")]
    should_start_at_zero: bool,

    /// Start numbering from the given number instead of 1
    #[arg(short = 's', long)]
    start_from: Option<usize>,

    /// Bold the line after the number; sample output:
    /// 1. **captured line**
    #[arg(short = 'b', long = "bold")]
    should_bold: bool,

    /// Renumbers (removes existing numbers) in the list
    #[arg(short = 'r', long = "renumber")]
    should_renumber: bool,
}

fn main() {
    let args = Args::parse();

    let stdin = io::stdin();
    let handle = stdin.lock();

    let mut number = match args.start_from {
        Some(start_value) => start_value,
        None => if args.should_start_at_zero { 0 } else { 1 },
    };

    // Compile once outside the processing loop
    // Matches leading whitespace, digits, and optional dots/dashes/parens
    let re = if args.should_renumber {
        Some(Regex::new(r"^\s*\d+[\.\)\-]?\s*").unwrap())
    } else {
        None
    };

    for line in handle.lines().map_while(Result::ok) {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            println!();
        }
        else {
            let processed = match &re {
                Some(re) => re.replace(trimmed, ""),
                None => std::borrow::Cow::Borrowed(trimmed),
            };

            let line = if args.should_bold {
                format!("**{processed}**")
            } else {
                processed.to_string()
            };

            println!("{number}. {line}");
            number += 1;
        }
    }
}
