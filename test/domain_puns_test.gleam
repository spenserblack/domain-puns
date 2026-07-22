import domain_puns
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn suggestions_test() {
  let name = "myfavoritecolorisblue"
  let domains = ["BLUE", "E", "WIBBLE", "WOBBLE"]

  assert domain_puns.suggestions(domains, name)
    == ["myfavoritecoloris.blue", "myfavoritecolorisblu.e"]
}
