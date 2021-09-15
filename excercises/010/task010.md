Input:

- L - list of integers - e.g. `[27, 17, 24, 25, 31, 21]`

Algorithm:

- convert each element into list of ones and zeros corresponding to its binary representation:
  - `27 -> [1, 1, 0, 1, 1]`
  - `17 -> [1, 0, 0, 0, 1]`
  - `24 -> [1, 1, 0, 0, 0]`
  - `25 -> [1, 1, 0, 0, 1]`
  - `31 -> [1, 1, 1, 1, 1]`
  - `21 -> [1, 0, 1, 0, 1]`
- covert each list of ones and zeros into a list of numbers corresponding to length of sublists consisting of equal elements
  - `[1, 1, 0, 1, 1] -> [2, 1, 2]`
  - `[1, 0, 0, 0, 1] -> [1, 3, 1]`
  - `[1, 1, 0, 0, 0] -> [2, 3]`
  - `[1, 1, 0, 0, 1] -> [2, 2, 1]`
  - `[1, 1, 1, 1, 1] -> [5]`
  - `[1, 0, 1, 0, 1] -> [1, 1, 1, 1, 1]`
- merge lists of digits into numbers to create key for the corresponding number from the original list
  - `[2, 1, 2] -> 212`
  - `[1, 3, 1] -> 131`
  - `[2, 3] -> 23`
  - `[2, 2, 1] -> 221`
  - `[5] -> 5`
  - `[1, 1, 1, 1, 1] -> 11111`
- sort numbers from the original list by keys
