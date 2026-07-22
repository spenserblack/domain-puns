import domain_puns
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

/// Simplified domain list for consistent testing and readability
const domains: List(String) = ["BLUE", "E", "WIBBLE", "WOBBLE", "XN--Q9JYB4C"]

pub fn suggestions_test() {
  let name = "myfavoritecolorisblue"

  assert domain_puns.suggestions(domains, name)
    == ["myfavoritecoloris.blue", "myfavoritecolorisblu.e"]
}

pub fn suggestions_punycode_test() {
  let name = "heyみんな"

  assert domain_puns.suggestions(domains, name) == ["hey.みんな"]
}
