import gleam/int
import gleam/io
import gleam/list

fn check_print_validity(
  requirements: List(#(Int, Int)),
  print: List(Int),
) -> Bool {
  case print {
    [page, ..rest] -> {
      let failed_requirement =
        list.find(requirements, fn(element) {
          let #(_, value) = element
          value == page
        })

      case failed_requirement {
        Ok(_) -> False
        Error(_) -> {
          list.filter(requirements, fn(value: #(Int, Int)) -> Bool {
            let #(required_value, _) = value
            required_value != page
          })
          |> check_print_validity(rest)
        }
      }
    }
    [] -> True
  }
}

fn start_checking_print_validity(
  requirements: List(#(Int, Int)),
  print: List(Int),
) -> Bool {
  // remove all requirements that could never be fulfilled, which is why we wouldnt care about them
  list.filter(requirements, fn(requirement) {
    let #(left_value, right_value) = requirement
    list.contains(print, left_value) && list.contains(print, right_value)
  })
  |> check_print_validity(print)
}

fn get_middle_page(print: List(Int)) -> Int {
  case print {
    [value] -> value
    [_, value, _] -> value
    [_, value] -> value
    [_, ..rest] -> {
      // removing the last element of a list seems a very hard problem to solve in gleam
      // so we do it this roundabout and inefficient way for now
      list.reverse(rest)
      |> list.drop(1)
      |> list.reverse
      |> get_middle_page
    }
    [] -> panic as "should never reach an empty list"
  }
}

fn add_internal(adders: List(Int), total: Int) {
  case adders {
    [multiplier, ..rest] -> add_internal(rest, total + multiplier)
    [] -> total
  }
}

fn add_elements(adders: List(Int)) {
  add_internal(adders, 0)
}

fn calculate_puzzle_sum(
  requirements: List(#(Int, Int)),
  prints: List(List(Int)),
) {
  list.filter(prints, start_checking_print_validity(requirements, _))
  |> list.map(get_middle_page)
  |> add_elements
}

pub fn main() {
  let solution = calculate_puzzle_sum(input_requirements, input_prints)
  io.debug("Day Five: " <> int.to_string(solution))
}

const input_prints = [
  [79, 33, 22, 64, 73, 93, 58], [27, 93, 55, 97, 43, 67, 84, 25, 34],
  [28, 55, 24, 77, 17, 14, 44],
  [79, 67, 97, 29, 47, 96, 45, 25, 44, 55, 43, 76, 77],
  [87, 84, 17, 25, 45, 44, 88], [88, 93, 72, 58, 73, 12, 57, 49, 51, 33, 64],
  [11, 28, 55, 24, 29, 56, 75],
  [73, 58, 65, 11, 93, 63, 81, 98, 33, 22, 79, 72, 64],
  [17, 44, 25, 43, 28, 77, 47],
  [
    65, 27, 78, 49, 79, 64, 52, 98, 12, 51, 38, 58, 73, 82, 81, 72, 14, 63, 33,
    45, 88,
  ], [29, 43, 47, 87, 75, 25, 34, 26, 32, 79, 82],
  [47, 67, 84, 75, 25, 34, 26, 32, 14, 44, 79, 58, 82, 72, 94, 64, 98],
  [38, 24, 31, 11, 82, 81, 72, 73, 63, 78, 65, 52, 98],
  [
    75, 25, 76, 67, 43, 56, 87, 45, 44, 96, 17, 34, 97, 58, 14, 79, 32, 29, 47,
    24, 84, 77, 26,
  ], [72, 73, 98, 81, 78, 22, 27, 11, 57, 28, 55, 24, 16],
  [52, 22, 57, 55, 24, 16, 76, 77, 43, 47, 67, 87, 25],
  [77, 56, 47, 87, 84, 17, 25, 34, 32, 14, 45, 44, 58, 88, 82, 72, 94],
  [84, 87, 29, 97, 55, 75, 32, 57, 31, 17, 76, 56, 16, 93, 25, 67, 26],
  [97, 31, 52, 25, 16, 11, 17],
  [
    38, 33, 65, 12, 78, 63, 52, 22, 27, 11, 31, 93, 57, 28, 55, 24, 16, 97, 76,
    77, 56, 43, 47,
  ], [43, 47, 67, 87, 75, 96, 14, 45, 79, 58, 51, 72, 94, 73, 64],
  [87, 96, 97, 28, 11, 43, 55, 31, 47, 76, 24, 25, 93, 57, 26, 34, 16],
  [63, 22, 11, 31, 93, 57, 24, 16, 97, 76, 77, 56, 47, 67, 87, 17, 75],
  [58, 82, 12, 78, 32, 94, 79, 72, 14, 26, 34, 81, 98, 45, 51, 63, 33],
  [32, 14, 45, 44, 58, 51, 88, 72, 73, 98, 81, 49, 38, 65, 12, 78, 63, 52, 22],
  [64, 49, 38, 52, 27, 31, 16, 97, 76], [93, 47, 28, 27, 33, 55, 67],
  [44, 79, 58, 88, 82, 72, 94, 73, 81, 49, 33, 65, 12, 63, 22, 11, 31],
  [
    88, 82, 72, 94, 73, 64, 98, 81, 49, 38, 33, 65, 12, 78, 63, 52, 22, 27, 11,
    31, 93, 57, 55,
  ],
  [
    84, 43, 11, 29, 17, 22, 55, 25, 75, 28, 97, 31, 56, 76, 27, 47, 77, 67, 24,
    57, 52,
  ],
  [
    73, 64, 98, 81, 49, 38, 33, 65, 12, 78, 63, 52, 22, 27, 11, 31, 93, 57, 24,
    97, 29,
  ], [93, 57, 28, 16, 97, 76, 43, 47, 67, 87, 75, 25, 96, 34, 26],
  [65, 78, 52, 27, 11, 31, 93, 57, 55, 97, 29, 76, 77, 56, 47, 67, 87],
  [97, 29, 76, 56, 43, 67, 84, 75, 25, 96, 34, 26, 32, 45, 44, 79, 58],
  [98, 82, 28, 49, 63, 27, 11, 24, 64, 72, 12, 55, 22, 94, 65, 52, 78, 38, 57],
  [
    29, 28, 55, 34, 87, 76, 96, 84, 45, 25, 77, 56, 32, 75, 16, 14, 57, 43, 26,
    24, 67, 17, 47,
  ], [11, 65, 43, 29, 63, 55, 56, 47, 57, 31, 78, 28, 77, 33, 38],
  [52, 22, 11, 28, 55, 24, 16, 97, 29, 76, 47, 17, 25],
  [24, 16, 97, 29, 77, 56, 47, 75, 25, 96, 34, 45, 44, 79, 58],
  [
    75, 45, 73, 51, 79, 96, 81, 49, 17, 88, 98, 26, 84, 25, 14, 87, 72, 44, 94,
    34, 58,
  ],
  [
    87, 84, 17, 25, 96, 34, 32, 14, 45, 79, 58, 51, 88, 82, 72, 94, 73, 64, 98,
    81, 49,
  ],
  [
    65, 12, 78, 52, 22, 27, 11, 31, 93, 57, 28, 55, 24, 16, 97, 29, 76, 77, 56,
    43, 47, 67, 87,
  ], [33, 78, 22, 27, 31, 28, 76, 56, 67],
  [
    25, 14, 32, 34, 87, 84, 28, 55, 77, 56, 47, 75, 24, 96, 16, 93, 97, 26, 17,
    29, 76,
  ], [84, 82, 43, 51, 94, 67, 25, 45, 64, 17, 75, 88, 79, 58, 73],
  [
    16, 84, 87, 77, 25, 96, 24, 34, 45, 47, 44, 56, 79, 29, 43, 14, 17, 75, 97,
    32, 67, 58, 76,
  ], [43, 67, 84, 96, 34, 32, 58, 88, 72, 73, 64], [12, 22, 16, 28, 84, 24, 27],
  [
    94, 17, 82, 64, 79, 87, 67, 45, 26, 72, 75, 32, 88, 14, 73, 51, 96, 98, 58,
    81, 44, 84, 25,
  ],
  [67, 84, 75, 25, 96, 34, 26, 14, 45, 44, 79, 58, 51, 88, 82, 72, 94, 73, 64],
  [77, 28, 55, 22, 31, 87, 24, 65, 78],
  [94, 11, 63, 28, 55, 78, 73, 22, 27, 81, 24, 72, 31, 65, 12],
  [96, 25, 73, 43, 64, 17, 87],
  [
    29, 76, 77, 56, 43, 47, 67, 87, 84, 17, 75, 25, 96, 34, 26, 32, 45, 44, 79,
    58, 51, 88, 82,
  ], [81, 49, 38, 33, 65, 78, 22, 27, 11, 31, 93, 57, 16, 97, 76, 77, 56],
  [
    16, 97, 29, 76, 77, 56, 43, 47, 67, 87, 84, 17, 75, 25, 96, 34, 26, 14, 45,
    44, 79, 58, 51,
  ],
  [
    67, 87, 84, 17, 75, 25, 96, 34, 32, 14, 45, 44, 79, 58, 51, 88, 82, 72, 94,
    73, 64, 98, 81,
  ], [79, 44, 94, 43, 82, 51, 88, 56, 14, 73, 34], [84, 67, 29, 34, 25, 76, 77],
  [58, 81, 64, 84, 25, 72, 88, 51, 82],
  [
    11, 17, 87, 97, 22, 76, 84, 24, 16, 47, 29, 27, 67, 57, 56, 31, 75, 63, 77,
    43, 28,
  ], [64, 98, 81, 65, 78, 63, 31, 57, 28, 55, 76],
  [72, 81, 49, 65, 52, 22, 11, 31, 28],
  [31, 93, 28, 16, 97, 76, 77, 56, 47, 87, 84, 17, 25, 96, 34, 26, 32],
  [88, 72, 65, 12, 63, 22, 11],
  [45, 38, 65, 49, 26, 72, 58, 33, 32, 81, 94, 98, 34, 14, 79, 51, 64, 96, 78],
  [51, 49, 12, 22, 27],
  [73, 64, 98, 81, 49, 38, 33, 78, 63, 52, 11, 31, 93, 57, 55, 24, 16, 97, 29],
  [64, 34, 84, 81, 73, 26, 17, 14, 96, 67, 98, 82, 79, 72, 45],
  [98, 81, 38, 65, 52, 31, 57, 28, 16, 29, 77],
  [64, 98, 49, 78, 22, 27, 11, 28, 24, 29, 76],
  [75, 25, 26, 79, 58, 51, 82, 64, 98, 33, 65],
  [76, 77, 67, 87, 84, 75, 25, 96, 34, 26, 45, 44, 79, 58, 51, 88, 72],
  [26, 76, 75, 32, 34, 24, 45, 28, 84, 96, 17, 97, 43, 44, 25],
  [24, 29, 67, 87, 25, 34, 32, 44, 58],
  [49, 38, 33, 78, 27, 11, 93, 57, 55, 97, 29, 76, 77, 56, 43],
  [29, 87, 76, 14, 45, 96, 57],
  [
    38, 82, 65, 98, 63, 51, 31, 57, 33, 22, 58, 93, 78, 73, 81, 94, 12, 27, 11,
    52, 49,
  ], [26, 45, 79, 88, 82, 72, 94, 98, 81, 49, 38, 63, 52],
  [14, 45, 44, 51, 88, 64, 98, 38, 65, 12, 78, 63, 27],
  [87, 75, 26, 32, 14, 44, 72], [73, 22, 12, 14, 63, 52, 82, 58, 78],
  [31, 28, 33, 67, 47, 22, 43, 65, 57, 76, 11],
  [94, 73, 64, 98, 49, 38, 65, 78, 52, 11, 93, 57, 16],
  [77, 67, 84, 17, 75, 34, 32, 44, 79, 58, 51, 72, 94],
  [38, 33, 65, 12, 63, 52, 27, 31, 93, 57, 16, 97, 76],
  [25, 11, 56, 77, 22, 57, 67, 16, 52, 29, 97, 75, 17, 28, 55],
  [
    49, 81, 33, 22, 65, 27, 51, 57, 82, 78, 11, 38, 93, 31, 63, 88, 98, 72, 73,
    52, 28, 12, 64,
  ],
  [
    34, 26, 32, 14, 45, 44, 79, 58, 51, 88, 82, 72, 94, 73, 64, 98, 81, 49, 38,
    65, 12, 78, 63,
  ], [64, 58, 88, 22, 44, 65, 51, 63, 31],
  [12, 49, 31, 72, 73, 79, 52, 11, 78, 64, 33, 93, 94],
  [31, 93, 57, 55, 16, 97, 29, 76, 43, 87, 84, 17, 25, 96, 34, 26, 32],
  [
    96, 34, 26, 32, 14, 44, 79, 58, 51, 88, 82, 72, 94, 73, 64, 98, 81, 49, 38,
    33, 65, 12, 78,
  ],
  [56, 43, 47, 87, 84, 17, 25, 96, 26, 14, 45, 44, 79, 58, 88, 82, 72, 94, 73],
  [56, 47, 87, 84, 25, 96, 34, 45, 79, 58, 51, 88, 72],
  [
    63, 72, 88, 64, 79, 44, 58, 33, 26, 32, 49, 98, 45, 94, 12, 34, 65, 78, 81,
    38, 82,
  ], [64, 33, 78, 63, 27, 93, 28, 55, 76], [45, 44, 58, 94, 12, 78, 11],
  [
    38, 33, 65, 12, 78, 63, 52, 22, 27, 11, 93, 28, 55, 24, 16, 97, 29, 76, 77,
    43, 47,
  ],
  [27, 17, 78, 31, 16, 57, 63, 87, 56, 97, 29, 67, 24, 55, 22, 93, 84, 11, 77],
  [67, 55, 25, 57, 43, 84, 31], [55, 16, 76, 77, 96, 26, 79],
  [
    87, 84, 75, 25, 96, 34, 26, 32, 14, 44, 79, 58, 51, 88, 82, 72, 94, 73, 64,
    98, 81,
  ],
  [
    63, 52, 22, 27, 11, 31, 93, 57, 28, 55, 24, 16, 97, 29, 76, 77, 56, 43, 47,
    67, 84, 17, 75,
  ],
  [73, 98, 81, 49, 38, 33, 65, 12, 63, 52, 22, 27, 11, 93, 57, 28, 55, 16, 29],
  [82, 73, 49, 33, 52], [31, 51, 38, 81, 98, 11, 64, 27, 79, 72, 44, 88, 63],
  [88, 82, 73, 64, 98, 38, 33, 65, 12, 78, 63, 22, 27, 11, 31, 93, 57, 28, 55],
  [
    44, 79, 58, 51, 88, 82, 72, 94, 73, 98, 81, 49, 38, 33, 65, 78, 63, 52, 22,
    11, 31,
  ],
  [
    96, 93, 29, 16, 17, 57, 47, 97, 24, 87, 25, 32, 67, 43, 76, 84, 14, 77, 28,
    26, 56,
  ], [25, 96, 26, 45, 58, 51, 72, 94, 64, 98, 81, 65, 12],
  [98, 38, 17, 26, 75, 34, 73, 51, 84],
  [52, 22, 27, 31, 28, 55, 24, 16, 97, 77, 56, 43, 47, 67, 87, 17, 25],
  [64, 25, 87, 75, 34, 67, 72, 17, 47, 94, 43],
  [98, 38, 65, 12, 78, 63, 52, 22, 11, 93, 57, 28, 55, 29, 76],
  [93, 75, 57, 22, 63, 97, 67], [14, 84, 96, 72, 43, 88, 58, 79, 34],
  [78, 57, 72, 12, 55, 73, 49, 31, 65, 11, 22, 27, 33, 24, 16],
  [33, 78, 98, 51, 63, 81, 31, 52, 82, 22, 65, 73, 94, 79, 58, 12, 27],
  [17, 75, 88, 82, 38, 81, 96, 64, 34, 45, 72, 26, 33],
  [
    22, 58, 44, 45, 12, 65, 64, 79, 49, 72, 14, 81, 82, 94, 52, 51, 33, 88, 78,
    32, 73, 98, 63,
  ],
  [
    49, 38, 33, 12, 63, 52, 22, 27, 11, 31, 93, 57, 28, 55, 24, 16, 97, 29, 76,
    77, 56,
  ], [47, 87, 84, 75, 25, 96, 34, 26, 45, 44, 58, 51, 88, 72, 94, 73, 98],
  [38, 57, 52, 56, 11, 29, 22, 12, 24, 81, 76],
  [
    82, 79, 98, 27, 51, 63, 94, 65, 52, 44, 78, 11, 88, 58, 22, 33, 12, 81, 45,
    64, 38, 73, 72,
  ], [79, 43, 56, 67, 26, 84, 58, 25, 72, 44, 87, 17, 96, 82, 51],
  [
    33, 52, 38, 63, 94, 31, 82, 51, 64, 11, 58, 22, 81, 73, 98, 78, 93, 27, 88,
    57, 12,
  ], [97, 27, 56, 38, 65, 78, 22, 28, 12, 33, 93],
  [16, 97, 22, 87, 29, 43, 31, 77, 76], [28, 16, 29, 67, 87, 14, 44],
  [44, 79, 51, 88, 82, 72, 94, 98, 49, 38, 33, 12, 78, 63, 52, 22, 31],
  [
    76, 77, 56, 43, 67, 87, 84, 17, 75, 25, 96, 34, 26, 32, 14, 45, 44, 79, 58,
    51, 88, 82, 72,
  ], [28, 16, 94, 81, 73, 38, 11, 31, 12, 97, 65, 93, 64, 24, 55],
  [
    65, 12, 78, 52, 22, 27, 11, 31, 93, 57, 28, 55, 24, 16, 97, 29, 76, 77, 56,
    43, 47, 67, 87,
  ], [45, 94, 64, 33, 52],
  [81, 28, 98, 93, 88, 33, 38, 64, 52, 22, 72, 31, 49, 65, 82, 73, 94],
  [79, 58, 72, 94, 73, 64, 81, 38, 33, 65, 12, 52, 22, 27, 11, 31, 93],
  [26, 32, 45, 44, 58, 51, 82, 72, 94, 73, 64, 81, 49, 33, 78, 63, 52],
  [47, 93, 76, 22, 67, 52, 55, 29, 97, 11, 12, 16, 78, 24, 57, 84, 63],
  [79, 58, 51, 88, 94, 64, 98, 49, 38, 33, 65, 12, 78, 63, 11, 31, 93],
  [25, 34, 26, 32, 44, 58, 94, 64, 98, 81, 38, 65, 12],
  [47, 93, 22, 29, 56, 57, 43, 11, 55, 65, 76, 97, 12, 16, 31, 87, 78],
  [38, 98, 78, 11, 77, 16, 93],
  [34, 17, 96, 26, 77, 75, 82, 72, 14, 43, 44, 32, 84, 94, 79],
  [75, 79, 51, 88, 82, 64, 38, 33, 65],
  [94, 64, 34, 12, 51, 72, 81, 49, 44, 78, 33, 98, 82, 65, 32, 79, 26, 63, 45],
  [22, 11, 31, 97, 29, 76, 56, 67, 96],
  [88, 76, 17, 32, 29, 97, 84, 45, 77, 34, 79, 47, 44, 67, 26, 25, 56],
  [55, 24, 97, 29, 76, 77, 56, 43, 67, 87, 84, 17, 75, 25, 96, 26, 14, 45, 79],
  [31, 93, 57, 28, 97, 29, 77, 43, 87, 17, 32],
  [27, 11, 31, 93, 28, 55, 24, 16, 97, 29, 76, 77, 47, 67, 87, 84, 96],
  [29, 76, 77, 56, 43, 47, 87, 84, 75, 25, 96, 34, 26, 32, 14, 44, 79, 88, 82],
  [94, 64, 38, 65, 63, 52, 27, 31, 28, 24, 97],
  [81, 98, 26, 38, 72, 82, 84, 49, 44],
  [51, 82, 72, 94, 64, 98, 49, 38, 12, 78, 63, 52, 22, 27, 31],
  [14, 75, 32, 88, 51, 43, 45], [34, 26, 82, 73, 64, 33, 65, 12, 63],
  [32, 17, 75, 25, 94, 81, 79, 51, 98, 26, 82],
  [34, 65, 98, 96, 49, 79, 72, 51, 78, 64, 81, 44, 73, 12, 94],
  [24, 47, 75, 34, 32],
  [
    38, 33, 65, 12, 78, 63, 52, 22, 11, 31, 57, 28, 55, 16, 97, 29, 76, 77, 56,
    43, 47,
  ], [51, 94, 73, 64, 98, 81, 33, 12, 78, 22, 27, 11, 31, 93, 28],
  [33, 63, 52, 22, 27, 11, 31, 93, 28, 55, 97, 29, 67],
  [
    65, 12, 78, 63, 52, 22, 27, 31, 93, 28, 55, 24, 97, 29, 76, 77, 56, 43, 47,
    67, 87,
  ], [34, 84, 87, 43, 29, 96, 26, 32, 56, 45, 44, 47, 28, 97, 75],
  [96, 58, 26, 51, 47, 16, 43, 87, 45, 67, 76],
  [27, 97, 76, 77, 67, 87, 84, 75, 34],
  [93, 77, 65, 29, 33, 27, 16, 38, 28, 81, 97, 98, 63, 76, 11, 55, 57, 31, 52],
  [11, 55, 24, 97, 43, 47, 84, 17, 26],
  [
    12, 73, 98, 81, 44, 45, 26, 88, 14, 82, 79, 64, 25, 94, 32, 72, 58, 33, 65,
    38, 51, 49, 96,
  ],
  [64, 44, 25, 58, 17, 88, 43, 79, 14, 75, 87, 45, 72, 47, 82, 51, 94, 67, 26],
  [94, 12, 38, 65, 44, 73, 64, 51, 52, 79, 88, 27, 81, 49, 11],
  [
    28, 14, 47, 77, 55, 43, 32, 75, 96, 29, 16, 57, 67, 34, 97, 26, 25, 87, 76,
    17, 56, 24, 45,
  ], [63, 52, 22, 11, 57, 28, 16, 29, 43, 47, 87, 84, 75],
  [98, 81, 33, 65, 12, 78, 52, 22, 11, 31, 93, 57, 55, 24, 16, 97, 29, 76, 77],
  [47, 67, 87, 84, 75, 34, 26, 14, 58, 82, 98],
  [64, 73, 79, 45, 65, 98, 44, 81, 78, 14, 82], [93, 56, 67, 25, 96, 32, 14],
  [45, 79, 82, 72, 94, 73, 64, 98, 81, 65, 12, 27, 11],
  [87, 17, 25, 34, 26, 45, 44, 79, 88, 82, 73, 64, 98, 81, 49],
  [12, 22, 63, 65, 38, 28, 94, 55, 49, 64, 24],
  [
    28, 55, 24, 16, 97, 29, 76, 56, 43, 47, 67, 87, 84, 17, 75, 96, 34, 26, 32,
    45, 44,
  ], [88, 79, 84, 67, 26, 51, 17],
  [
    96, 88, 56, 47, 67, 58, 79, 34, 51, 76, 72, 43, 14, 45, 82, 87, 44, 26, 84,
    75, 77,
  ],
  [
    38, 33, 65, 12, 78, 63, 52, 22, 27, 11, 31, 93, 28, 55, 24, 16, 97, 29, 76,
    77, 56, 43, 47,
  ],
]

const input_requirements = [
  #(87, 51), #(88, 11), #(88, 27), #(16, 32), #(16, 76), #(16, 51), #(51, 93),
  #(51, 55), #(51, 49), #(51, 11), #(98, 63), #(98, 12), #(98, 49), #(98, 77),
  #(98, 78), #(82, 24), #(82, 22), #(82, 12), #(82, 31), #(82, 73), #(82, 94),
  #(75, 94), #(75, 82), #(75, 72), #(75, 38), #(75, 45), #(75, 25), #(75, 12),
  #(84, 75), #(84, 79), #(84, 64), #(84, 33), #(84, 51), #(84, 94), #(84, 81),
  #(84, 25), #(49, 56), #(49, 78), #(49, 33), #(49, 77), #(49, 57), #(49, 97),
  #(49, 12), #(49, 43), #(49, 93), #(17, 34), #(17, 26), #(17, 94), #(17, 33),
  #(17, 58), #(17, 51), #(17, 38), #(17, 14), #(17, 65), #(17, 25), #(52, 11),
  #(52, 24), #(52, 97), #(52, 87), #(52, 43), #(52, 57), #(52, 27), #(52, 31),
  #(52, 29), #(52, 77), #(52, 25), #(58, 94), #(58, 51), #(58, 33), #(58, 72),
  #(58, 38), #(58, 64), #(58, 63), #(58, 65), #(58, 12), #(58, 98), #(58, 88),
  #(58, 22), #(33, 11), #(33, 65), #(33, 47), #(33, 16), #(33, 56), #(33, 24),
  #(33, 97), #(33, 22), #(33, 67), #(33, 63), #(33, 12), #(33, 52), #(33, 55),
  #(97, 75), #(97, 58), #(97, 51), #(97, 26), #(97, 87), #(97, 82), #(97, 88),
  #(97, 56), #(97, 14), #(97, 67), #(97, 47), #(97, 43), #(97, 79), #(97, 17),
  #(65, 52), #(65, 11), #(65, 31), #(65, 77), #(65, 29), #(65, 78), #(65, 22),
  #(65, 84), #(65, 24), #(65, 43), #(65, 16), #(65, 97), #(65, 93), #(65, 55),
  #(65, 28), #(78, 52), #(78, 27), #(78, 56), #(78, 16), #(78, 67), #(78, 63),
  #(78, 28), #(78, 77), #(78, 87), #(78, 75), #(78, 22), #(78, 17), #(78, 24),
  #(78, 97), #(78, 57), #(78, 47), #(67, 84), #(67, 79), #(67, 87), #(67, 98),
  #(67, 73), #(67, 26), #(67, 34), #(67, 58), #(67, 75), #(67, 44), #(67, 17),
  #(67, 49), #(67, 45), #(67, 81), #(67, 94), #(67, 51), #(67, 32), #(47, 32),
  #(47, 72), #(47, 81), #(47, 98), #(47, 84), #(47, 17), #(47, 75), #(47, 34),
  #(47, 87), #(47, 82), #(47, 79), #(47, 25), #(47, 26), #(47, 96), #(47, 51),
  #(47, 58), #(47, 45), #(47, 94), #(76, 72), #(76, 44), #(76, 87), #(76, 82),
  #(76, 96), #(76, 67), #(76, 43), #(76, 45), #(76, 84), #(76, 88), #(76, 32),
  #(76, 75), #(76, 56), #(76, 17), #(76, 34), #(76, 79), #(76, 77), #(76, 25),
  #(76, 94), #(63, 43), #(63, 17), #(63, 56), #(63, 27), #(63, 67), #(63, 87),
  #(63, 29), #(63, 31), #(63, 55), #(63, 24), #(63, 52), #(63, 25), #(63, 77),
  #(63, 28), #(63, 93), #(63, 47), #(63, 76), #(63, 22), #(63, 57), #(63, 75),
  #(72, 22), #(72, 33), #(72, 11), #(72, 57), #(72, 73), #(72, 55), #(72, 97),
  #(72, 31), #(72, 52), #(72, 27), #(72, 64), #(72, 12), #(72, 63), #(72, 28),
  #(72, 98), #(72, 49), #(72, 38), #(72, 78), #(72, 94), #(72, 65), #(72, 24),
  #(45, 81), #(45, 78), #(45, 51), #(45, 79), #(45, 94), #(45, 52), #(45, 31),
  #(45, 73), #(45, 33), #(45, 82), #(45, 44), #(45, 98), #(45, 65), #(45, 64),
  #(45, 38), #(45, 72), #(45, 88), #(45, 58), #(45, 63), #(45, 12), #(45, 11),
  #(45, 49), #(43, 32), #(43, 73), #(43, 88), #(43, 26), #(43, 14), #(43, 51),
  #(43, 75), #(43, 82), #(43, 44), #(43, 72), #(43, 45), #(43, 98), #(43, 58),
  #(43, 64), #(43, 17), #(43, 96), #(43, 34), #(43, 79), #(43, 47), #(43, 94),
  #(43, 87), #(43, 67), #(43, 25), #(94, 49), #(94, 93), #(94, 16), #(94, 31),
  #(94, 73), #(94, 38), #(94, 63), #(94, 65), #(94, 55), #(94, 29), #(94, 57),
  #(94, 24), #(94, 11), #(94, 64), #(94, 33), #(94, 97), #(94, 78), #(94, 12),
  #(94, 81), #(94, 22), #(94, 27), #(94, 98), #(94, 52), #(94, 28), #(11, 76),
  #(11, 93), #(11, 24), #(11, 55), #(11, 75), #(11, 96), #(11, 97), #(11, 26),
  #(11, 56), #(11, 16), #(11, 43), #(11, 34), #(11, 31), #(11, 87), #(11, 28),
  #(11, 25), #(11, 57), #(11, 67), #(11, 17), #(11, 77), #(11, 29), #(11, 32),
  #(11, 84), #(11, 47), #(24, 34), #(24, 67), #(24, 25), #(24, 16), #(24, 58),
  #(24, 51), #(24, 14), #(24, 44), #(24, 45), #(24, 32), #(24, 97), #(24, 75),
  #(24, 29), #(24, 87), #(24, 56), #(24, 43), #(24, 84), #(24, 77), #(24, 96),
  #(24, 79), #(24, 26), #(24, 17), #(24, 76), #(24, 47), #(73, 16), #(73, 65),
  #(73, 78), #(73, 22), #(73, 76), #(73, 81), #(73, 38), #(73, 52), #(73, 27),
  #(73, 31), #(73, 49), #(73, 29), #(73, 57), #(73, 97), #(73, 55), #(73, 93),
  #(73, 63), #(73, 33), #(73, 24), #(73, 98), #(73, 64), #(73, 12), #(73, 11),
  #(73, 28), #(34, 38), #(34, 45), #(34, 63), #(34, 49), #(34, 33), #(34, 52),
  #(34, 12), #(34, 32), #(34, 94), #(34, 72), #(34, 26), #(34, 98), #(34, 78),
  #(34, 58), #(34, 82), #(34, 79), #(34, 14), #(34, 64), #(34, 65), #(34, 51),
  #(34, 44), #(34, 88), #(34, 73), #(34, 81), #(96, 81), #(96, 49), #(96, 26),
  #(96, 72), #(96, 82), #(96, 98), #(96, 32), #(96, 94), #(96, 33), #(96, 65),
  #(96, 44), #(96, 73), #(96, 51), #(96, 38), #(96, 63), #(96, 34), #(96, 58),
  #(96, 45), #(96, 14), #(96, 78), #(96, 79), #(96, 64), #(96, 88), #(96, 12),
  #(27, 31), #(27, 25), #(27, 97), #(27, 67), #(27, 96), #(27, 57), #(27, 16),
  #(27, 29), #(27, 11), #(27, 34), #(27, 26), #(27, 55), #(27, 28), #(27, 47),
  #(27, 56), #(27, 87), #(27, 43), #(27, 76), #(27, 93), #(27, 75), #(27, 84),
  #(27, 17), #(27, 77), #(27, 24), #(93, 34), #(93, 43), #(93, 28), #(93, 16),
  #(93, 97), #(93, 45), #(93, 55), #(93, 76), #(93, 77), #(93, 24), #(93, 96),
  #(93, 47), #(93, 29), #(93, 17), #(93, 67), #(93, 87), #(93, 26), #(93, 32),
  #(93, 57), #(93, 56), #(93, 84), #(93, 25), #(93, 75), #(93, 14), #(55, 34),
  #(55, 44), #(55, 84), #(55, 58), #(55, 14), #(55, 45), #(55, 16), #(55, 47),
  #(55, 43), #(55, 25), #(55, 56), #(55, 29), #(55, 24), #(55, 79), #(55, 97),
  #(55, 76), #(55, 87), #(55, 26), #(55, 96), #(55, 17), #(55, 67), #(55, 77),
  #(55, 75), #(55, 32), #(22, 57), #(22, 27), #(22, 56), #(22, 17), #(22, 67),
  #(22, 93), #(22, 84), #(22, 43), #(22, 31), #(22, 55), #(22, 16), #(22, 75),
  #(22, 77), #(22, 25), #(22, 28), #(22, 96), #(22, 76), #(22, 11), #(22, 47),
  #(22, 97), #(22, 29), #(22, 34), #(22, 87), #(22, 24), #(81, 49), #(81, 24),
  #(81, 43), #(81, 65), #(81, 38), #(81, 16), #(81, 29), #(81, 22), #(81, 93),
  #(81, 33), #(81, 52), #(81, 77), #(81, 27), #(81, 55), #(81, 78), #(81, 28),
  #(81, 31), #(81, 76), #(81, 11), #(81, 56), #(81, 12), #(81, 97), #(81, 57),
  #(81, 63), #(56, 51), #(56, 67), #(56, 17), #(56, 96), #(56, 64), #(56, 45),
  #(56, 32), #(56, 72), #(56, 58), #(56, 79), #(56, 82), #(56, 84), #(56, 44),
  #(56, 75), #(56, 73), #(56, 34), #(56, 47), #(56, 94), #(56, 25), #(56, 43),
  #(56, 88), #(56, 87), #(56, 26), #(56, 14), #(31, 32), #(31, 87), #(31, 75),
  #(31, 24), #(31, 47), #(31, 14), #(31, 34), #(31, 43), #(31, 16), #(31, 29),
  #(31, 28), #(31, 17), #(31, 93), #(31, 57), #(31, 76), #(31, 26), #(31, 67),
  #(31, 55), #(31, 97), #(31, 56), #(31, 25), #(31, 77), #(31, 96), #(31, 84),
  #(14, 78), #(14, 11), #(14, 33), #(14, 73), #(14, 98), #(14, 64), #(14, 44),
  #(14, 79), #(14, 49), #(14, 88), #(14, 45), #(14, 22), #(14, 12), #(14, 38),
  #(14, 94), #(14, 51), #(14, 58), #(14, 63), #(14, 52), #(14, 27), #(14, 65),
  #(14, 72), #(14, 82), #(14, 81), #(25, 32), #(25, 51), #(25, 73), #(25, 38),
  #(25, 72), #(25, 78), #(25, 81), #(25, 45), #(25, 14), #(25, 12), #(25, 88),
  #(25, 65), #(25, 26), #(25, 34), #(25, 79), #(25, 33), #(25, 44), #(25, 64),
  #(25, 94), #(25, 58), #(25, 96), #(25, 98), #(25, 82), #(25, 49), #(32, 14),
  #(32, 22), #(32, 58), #(32, 51), #(32, 73), #(32, 44), #(32, 65), #(32, 45),
  #(32, 38), #(32, 52), #(32, 12), #(32, 81), #(32, 94), #(32, 64), #(32, 88),
  #(32, 79), #(32, 82), #(32, 63), #(32, 78), #(32, 49), #(32, 72), #(32, 98),
  #(32, 27), #(32, 33), #(29, 96), #(29, 79), #(29, 43), #(29, 58), #(29, 14),
  #(29, 67), #(29, 17), #(29, 26), #(29, 88), #(29, 51), #(29, 45), #(29, 77),
  #(29, 44), #(29, 87), #(29, 47), #(29, 25), #(29, 32), #(29, 84), #(29, 76),
  #(29, 72), #(29, 56), #(29, 34), #(29, 75), #(29, 82), #(57, 87), #(57, 84),
  #(57, 29), #(57, 32), #(57, 28), #(57, 14), #(57, 34), #(57, 76), #(57, 17),
  #(57, 25), #(57, 97), #(57, 24), #(57, 55), #(57, 67), #(57, 26), #(57, 16),
  #(57, 75), #(57, 47), #(57, 96), #(57, 77), #(57, 56), #(57, 45), #(57, 43),
  #(57, 44), #(26, 79), #(26, 72), #(26, 65), #(26, 58), #(26, 63), #(26, 73),
  #(26, 88), #(26, 22), #(26, 32), #(26, 78), #(26, 82), #(26, 12), #(26, 49),
  #(26, 98), #(26, 52), #(26, 14), #(26, 45), #(26, 94), #(26, 38), #(26, 33),
  #(26, 81), #(26, 44), #(26, 64), #(26, 51), #(64, 81), #(64, 65), #(64, 57),
  #(64, 38), #(64, 28), #(64, 98), #(64, 29), #(64, 63), #(64, 11), #(64, 97),
  #(64, 77), #(64, 52), #(64, 12), #(64, 49), #(64, 27), #(64, 16), #(64, 76),
  #(64, 33), #(64, 24), #(64, 78), #(64, 93), #(64, 22), #(64, 31), #(64, 55),
  #(79, 82), #(79, 57), #(79, 38), #(79, 49), #(79, 11), #(79, 73), #(79, 88),
  #(79, 94), #(79, 93), #(79, 22), #(79, 31), #(79, 27), #(79, 63), #(79, 98),
  #(79, 64), #(79, 58), #(79, 51), #(79, 72), #(79, 65), #(79, 78), #(79, 81),
  #(79, 12), #(79, 52), #(79, 33), #(28, 44), #(28, 55), #(28, 84), #(28, 76),
  #(28, 14), #(28, 16), #(28, 79), #(28, 96), #(28, 77), #(28, 24), #(28, 25),
  #(28, 29), #(28, 87), #(28, 56), #(28, 32), #(28, 97), #(28, 45), #(28, 43),
  #(28, 34), #(28, 47), #(28, 67), #(28, 17), #(28, 26), #(28, 75), #(44, 79),
  #(44, 63), #(44, 81), #(44, 51), #(44, 82), #(44, 94), #(44, 11), #(44, 65),
  #(44, 33), #(44, 72), #(44, 98), #(44, 49), #(44, 22), #(44, 38), #(44, 58),
  #(44, 93), #(44, 88), #(44, 52), #(44, 12), #(44, 73), #(44, 78), #(44, 27),
  #(44, 64), #(44, 31), #(12, 52), #(12, 27), #(12, 84), #(12, 97), #(12, 28),
  #(12, 63), #(12, 77), #(12, 11), #(12, 87), #(12, 16), #(12, 56), #(12, 17),
  #(12, 78), #(12, 55), #(12, 31), #(12, 24), #(12, 57), #(12, 43), #(12, 93),
  #(12, 47), #(12, 29), #(12, 22), #(12, 76), #(12, 67), #(38, 43), #(38, 47),
  #(38, 67), #(38, 63), #(38, 16), #(38, 33), #(38, 65), #(38, 76), #(38, 56),
  #(38, 31), #(38, 27), #(38, 57), #(38, 12), #(38, 29), #(38, 93), #(38, 55),
  #(38, 78), #(38, 24), #(38, 52), #(38, 11), #(38, 28), #(38, 97), #(38, 22),
  #(38, 77), #(77, 34), #(77, 45), #(77, 56), #(77, 43), #(77, 94), #(77, 25),
  #(77, 51), #(77, 58), #(77, 72), #(77, 14), #(77, 47), #(77, 84), #(77, 79),
  #(77, 87), #(77, 32), #(77, 82), #(77, 26), #(77, 96), #(77, 75), #(77, 73),
  #(77, 17), #(77, 88), #(77, 44), #(77, 67), #(87, 94), #(87, 82), #(87, 34),
  #(87, 79), #(87, 72), #(87, 64), #(87, 75), #(87, 98), #(87, 73), #(87, 81),
  #(87, 44), #(87, 14), #(87, 26), #(87, 32), #(87, 17), #(87, 49), #(87, 58),
  #(87, 88), #(87, 38), #(87, 84), #(87, 96), #(87, 25), #(87, 45), #(88, 82),
  #(88, 73), #(88, 22), #(88, 52), #(88, 33), #(88, 65), #(88, 24), #(88, 98),
  #(88, 49), #(88, 93), #(88, 55), #(88, 64), #(88, 28), #(88, 72), #(88, 57),
  #(88, 63), #(88, 78), #(88, 94), #(88, 81), #(88, 38), #(88, 31), #(88, 12),
  #(16, 14), #(16, 29), #(16, 67), #(16, 43), #(16, 26), #(16, 79), #(16, 34),
  #(16, 75), #(16, 56), #(16, 96), #(16, 45), #(16, 84), #(16, 77), #(16, 17),
  #(16, 25), #(16, 87), #(16, 88), #(16, 97), #(16, 58), #(16, 44), #(16, 47),
  #(51, 81), #(51, 72), #(51, 31), #(51, 65), #(51, 27), #(51, 12), #(51, 64),
  #(51, 38), #(51, 63), #(51, 78), #(51, 33), #(51, 94), #(51, 28), #(51, 22),
  #(51, 57), #(51, 82), #(51, 88), #(51, 73), #(51, 52), #(51, 98), #(98, 29),
  #(98, 38), #(98, 31), #(98, 11), #(98, 97), #(98, 16), #(98, 52), #(98, 33),
  #(98, 27), #(98, 65), #(98, 56), #(98, 55), #(98, 28), #(98, 81), #(98, 57),
  #(98, 24), #(98, 93), #(98, 76), #(98, 22), #(82, 64), #(82, 93), #(82, 81),
  #(82, 63), #(82, 11), #(82, 33), #(82, 55), #(82, 57), #(82, 65), #(82, 78),
  #(82, 52), #(82, 98), #(82, 49), #(82, 16), #(82, 27), #(82, 38), #(82, 72),
  #(82, 28), #(75, 81), #(75, 44), #(75, 51), #(75, 79), #(75, 33), #(75, 26),
  #(75, 58), #(75, 65), #(75, 98), #(75, 32), #(75, 64), #(75, 49), #(75, 96),
  #(75, 73), #(75, 34), #(75, 14), #(75, 88), #(84, 34), #(84, 72), #(84, 73),
  #(84, 44), #(84, 38), #(84, 17), #(84, 26), #(84, 32), #(84, 96), #(84, 82),
  #(84, 88), #(84, 58), #(84, 49), #(84, 14), #(84, 45), #(84, 98), #(49, 31),
  #(49, 38), #(49, 63), #(49, 52), #(49, 28), #(49, 11), #(49, 16), #(49, 29),
  #(49, 27), #(49, 76), #(49, 55), #(49, 22), #(49, 24), #(49, 47), #(49, 65),
  #(17, 98), #(17, 64), #(17, 44), #(17, 96), #(17, 45), #(17, 75), #(17, 32),
  #(17, 82), #(17, 49), #(17, 81), #(17, 88), #(17, 79), #(17, 73), #(17, 72),
  #(52, 56), #(52, 16), #(52, 28), #(52, 55), #(52, 84), #(52, 17), #(52, 96),
  #(52, 76), #(52, 67), #(52, 93), #(52, 47), #(52, 75), #(52, 22), #(58, 52),
  #(58, 31), #(58, 11), #(58, 81), #(58, 78), #(58, 73), #(58, 93), #(58, 27),
  #(58, 57), #(58, 49), #(58, 82), #(58, 28), #(33, 93), #(33, 29), #(33, 27),
  #(33, 57), #(33, 76), #(33, 28), #(33, 78), #(33, 87), #(33, 43), #(33, 31),
  #(33, 77), #(97, 96), #(97, 76), #(97, 34), #(97, 44), #(97, 32), #(97, 45),
  #(97, 25), #(97, 77), #(97, 29), #(97, 84), #(65, 12), #(65, 47), #(65, 87),
  #(65, 76), #(65, 67), #(65, 63), #(65, 57), #(65, 27), #(65, 56), #(78, 31),
  #(78, 84), #(78, 93), #(78, 29), #(78, 76), #(78, 55), #(78, 43), #(78, 11),
  #(67, 96), #(67, 82), #(67, 88), #(67, 25), #(67, 14), #(67, 64), #(67, 72),
  #(47, 14), #(47, 64), #(47, 73), #(47, 67), #(47, 88), #(47, 44), #(76, 26),
  #(76, 47), #(76, 51), #(76, 14), #(76, 58), #(63, 84), #(63, 97), #(63, 16),
  #(63, 11), #(72, 81), #(72, 93), #(72, 16), #(45, 27), #(45, 22), #(43, 84),
]
