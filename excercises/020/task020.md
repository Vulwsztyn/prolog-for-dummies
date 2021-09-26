Input:

- I - list of intervals - e.g. `[[-3, 5], [0, 7], [2, 10], [3, 8], [-2, 2]]`
- L - sorted list of integers - e.g. `[-4, -1, 2, 4, 5, 7, 8, 9]`

Algorithm:

- for each element of I generate a flitered version o L consisting only of elements that are inside the interval (inclusively)
  - `[-3, 5] -> [-1, 2, 4, 5]`
  - `[0, 7] -> [2, 4, 5, 7]`
  - `[2, 10] -> [2, 4, 5, 7, 8, 9]`
  - `[3, 8] -> [4, 5, 7, 8] <- 8 is here since inclusively`
  - `[-2, 2] -> [-1, 2]`
- for each element of I find it's middle (average of its start and end)
  - `[-3, 5] -> 1`
  - `[0, 7] -> 3.5`
  - `[2, 10] -> 6`
  - `[3, 8] -> 5.5`
  - `[-2, 2] -> 0`
- for each interval in I find element of list from the first point that is furthest from the middle thus obtaining the key
  - `[-3, 5] -> [-1, 2, 4, 5] -> 5`
  - `[0, 7] -> [2, 4, 5, 7] -> 7`
  - `[2, 10] -> [2, 4, 5, 7, 8, 9] -> 2`
  - `[3, 8] -> [4, 5, 7, 8] -> 8`
  - `[-2, 2] -> [-1, 2] -> 2`
- find max by key