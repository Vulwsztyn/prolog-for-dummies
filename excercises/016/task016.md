Input:

- L - list of ints - e.g. `[21, 15, 11]`

Algorithm:

- map L to binary
  - `21 -> [1, 0, 1, 0, 1]`
  - `15 -> [1, 1, 1, 1]`
  - `11 -> [1, 0, 1, 1]`
- squeeze consecutive bits
  - `21 -> [1, 0, 1, 0, 1] -> [1, 0, 1, 0, 1]`
  - `15 -> [1, 1, 1, 1] -> [1]`
  - `11 -> [1, 0, 1, 1] -> [1, 0, 1]`
- convert from binary to get key
  - `21 -> [1, 0, 1, 0, 1] -> [1, 0, 1, 0, 1] -> 21`
  - `15 -> [1, 1, 1, 1] -> [1] -> 1`
  - `11 -> [1, 0, 1, 1] -> [1, 0, 1] -> 5`
- sort by key
