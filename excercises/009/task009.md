Input:

- L - list of integers - e.g. `[123, 537, 153, 162]`

Algorithm:

- split each element of the list into it's digits:
  - `123 -> [1, 2, 3]`
  - `537 -> [5, 3, 7]`
  - `153 -> [1, 5, 3]`
  - `162 -> [1, 6, 2]`
- from each list of digits remove digits that compromise it's monotonicity
  - `[1, 2, 3] -> [1, 2, 3]`
  - `[5, 3, 7] -> [5, 7]`
  - `[1, 5, 3] -> [1, 5]`
  - `[1, 6, 2] -> [1, 6]`
- merge lists of digits into numbers to create key for the corresponding number from the original list
  - `[1, 2, 3] -> 123`
  - `[5, 7] -> 57`
  - `[1, 5] -> 15`
  - `[1, 6] -> 16`
- sort numbers from the original list by keys
