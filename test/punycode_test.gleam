import domain_puns/punycode
import gleam/result
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn matches_domain_error_test() {
  let name = "COM"

  assert { punycode.matches_domain(name) |> result.is_error }
}

pub fn matches_domain_true_test() {
  let name = "XN--Q9JYB4C"

  assert { punycode.matches_domain(name) |> result.unwrap("") } == "q9jyb4c"
}
