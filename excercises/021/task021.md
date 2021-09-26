Input:

- I - list of intervals - e.g. `[[-3, 1], [3, 7], [6, 10], [8, 11]]`
- L - sorted list of integers - e.g. `[-4, -1, 1, 2, 6, 9, 10, 12]`

Algorithm:

- for each element of I generate a flitered version o L consisting only of elements that are inside the interval (inclusively)
  - `[-3, 1] -> [-1, 1]`
  - `[3, 7] -> [6]`
  - `[6, 10] -> [6, 9, 10]`
  - `[8, 11] -> [9, 10]`
- concatenate the lists from the previous step and remove duplicates
 - `[-1, 1] + [6] + [6, 9, 10] + [9, 10] -> [-1, 1, 6, 9, 10]`
- for each interval of I find the elements of the list from the previous step that are NOT inside it
  - `[-3, 1] -> [6, 9, 10]`
  - `[3, 7] -> [-1, 1, 9, 10]`
  - `[6, 10] -> [-1, 1]`
  - `[8, 11] -> [-1, 1, 6]`
- get length of each list from the previous step thus creating key for each interval