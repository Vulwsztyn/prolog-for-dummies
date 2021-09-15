Input:

- L - list of lists - e.g. `[[1, 2, 3], [1, 2, 1], [1, 2, 1, 1, 1]]`

Algorithm:

- find max
  - `[1, 2, 3] -> 3`
  - `[1, 4, 1] -> 4`
  - `[1, 2, 1, 1, 1] -> 2`
- remove elements from list's either end so that the max is in the middle
  - `[1, 2, 3] -> 3 -> [3]`
  - `[1, 4, 1] -> 2 -> [1, 4, 1]`
  - `[1, 2, 1, 1, 1] -> 2 -> [1, 2, 1]`
- get average of lists from previous step to get key
  - `[1, 2, 3] -> 3 -> [3] -> 3`
  - `[1, 4, 1] -> 2 -> [1, 4, 1] -> 5/3`
  - `[1, 2, 1, 1, 1] -> 2 -> [1, 2, 1] -> 4/3`
- sort by key
