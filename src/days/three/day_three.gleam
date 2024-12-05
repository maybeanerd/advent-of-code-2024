import gleam/io
import gleam/regexp
import gleam/result

fn create_regex() {
  regexp.from_string("mul\\(\\d+\\d?\\d?,\\d+\\d?\\d?\\)")
  // TODO
}

pub fn main() {
  use expression <- result.try(create_regex())
  let solution = regexp.scan(content: example_input, with: expression)

  io.debug(solution)
  io.debug("Day Three: " <> "TODO")
}

const example_input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
