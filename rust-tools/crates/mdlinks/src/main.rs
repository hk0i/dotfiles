use std::io::{self, Read};
use regex::Regex;
use std::collections::HashSet;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut document = String::new();
    io::stdin().read_to_string(&mut document)?;

    let mut document_links = parse_content_links(&document)?;
    let footnote_links = parse_footnote_links(&document)?;

    if !document_links.is_empty() {
        document = document.trim_end_matches('\n').to_string();
    }

    print!("{document}");

    // keep only the new links (discard what's already in footnotes)
    document_links.retain(|link| !footnote_links.contains(link));

    if !document_links.is_empty() {
        // explicit empty check to add blank line before showing footnotes
        println!();
        for link in &document_links {
            println!("[{link}]: ");
        }
    }

    Ok(())
}

/// Extracts all links from the document's content
fn parse_content_links(document: &str) -> Result<HashSet<String>, regex::Error> {
    let mut document_links = HashSet::new();

    // compile regex pattern using regex strings to avoid escaping: `r#"string"#`
    let link_pattern = Regex::new(r#"(\[([^\]]+)\]\[([^\]]*)\])"#)?;

    for capture in link_pattern.captures_iter(&document) {
        let title = &capture[2];
        let reference_name = &capture[3];

        let footer_link = (!reference_name.is_empty())
            .then_some(reference_name)
            .unwrap_or(title);

        document_links.insert(footer_link.to_string());
    }

    Ok(document_links)
}

/// Extracts only the footnote links from the footnotes section (bottom) of the document.
fn parse_footnote_links(document: &str) -> Result<HashSet<String>, regex::Error> {
    let footnote_link_pattern = Regex::new(r#"(?m)^\[([^\]]+)\]:"#)?;
    let mut links = HashSet::new();

    for capture in footnote_link_pattern.captures_iter(document) {
        links.insert(capture[1].to_string());
    }

    Ok(links)
}
