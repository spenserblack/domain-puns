import argv
import domain_puns/domains
import domain_puns/punycode as punycode_helper
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import glidna/punycode

pub fn main() -> Nil {
  let args = argv.load()
  case args.arguments {
    [name] -> suggestions(domains.domains, name) |> list.each(io.println)
    _ -> args.program |> usage |> io.println_error
  }
}

fn usage(exe: String) -> String {
  exe <> " <PROJECT_NAME>"
}

/// Uses the list of top-level domains to suggest domains for your site's name.
pub fn suggestions(top_level: List(String), name: String) -> List(String) {
  top_level
  |> list.map(fn(tl) { string.lowercase(tl) })
  |> list.filter_map(fn(tl) { do_suggest(tl, name) })
}

/// Creates a suggestion for a single domain and project name.
fn do_suggest(top_level: String, name: String) -> Result(String, Nil) {
  case punycode_helper.matches_domain(top_level) {
    Ok(encoded) -> do_punycode_suggest(encoded, name)
    Error(Nil) -> do_plain_text_suggest(top_level, name)
  }
}

/// Creates a suggestion for a punycode domain. Takes the encoded punycode *without* the
/// `xn--` prefix
fn do_punycode_suggest(encoded: String, name: String) -> Result(String, Nil) {
  punycode.from_ascii(encoded)
  |> result.try(fn(domain) { do_plain_text_suggest(domain, name) })
}

/// Creates a suggestion for a plain-text (not encoded) domain.
fn do_plain_text_suggest(
  top_level: String,
  name: String,
) -> Result(String, Nil) {
  case string.ends_with(name, top_level) {
    True -> Ok(string.remove_suffix(name, top_level) <> "." <> top_level)
    False -> Error(Nil)
  }
}
