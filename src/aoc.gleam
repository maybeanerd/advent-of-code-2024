import gleam/io
import gleam/order
import gleam/list

fn sort_list_items(a: Int, b: Int){
  case a==b {
    True-> order.Eq
    _-> case a>b {
      True-> order.Gt
      False-> order.Lt
    }
  }
}

fn compare_two_lists (left_list: List(Int), right_list: List(Int)){
  let sorted_left_list = list.sort(left_list,  sort_list_items)
  let sorted_right_list = list.sort(right_list, sort_list_items)

 io.debug("Left list: ")
  io.debug(
    sorted_left_list
  )
  io.debug("Right list: ")
  io.debug(sorted_right_list)

}

pub fn main() {
  // TODO get lists from test input
  let left_list = [0,1,2]
  let right_list = [9,7,1]

  compare_two_lists(left_list, right_list)
}
