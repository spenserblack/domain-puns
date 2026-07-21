import argv
import domain_puns/domains
import gleam/io
import gleam/list
import gleam/string

const usage: String = "domain_puns <PROJECT_NAME>"

pub fn main() -> Nil {
  case argv.load().arguments {
    [name] -> suggestions(domains.domains, name) |> list.each(io.println)
    _ -> io.println_error(usage)
  }
}

/// Uses the list of top-level domains to suggest domains for your site's name.
pub fn suggestions(top_level: List(String), name: String) -> List(String) {
  top_level
  |> list.map(fn(tl) { string.lowercase(tl) })
  |> list.filter(fn(tl) { string.ends_with(name, tl) })
  |> list.map(fn(tl) { string.remove_suffix(name, tl) <> "." <> tl })
}
