Input:

- L - list of intervals - e.g. `[[-1,3],[14,20],[0,14]]`

Algorithm:

- map each interval to it's middle:
  - `[-1,3] -> 1`
  - `[14,20] -> 17`
  - `[0,14] -> 7`
- for each middle find the another middle closets to it
  - `[-1,3] -> 1 -> 7`
  - `[14,20] -> 17 -> 7`
  - `[0,14] -> 7 -> 1`
- map "pairs of middles" from the previous points to their differences to get keys
- for each middle find the another middle closets to it
  - `[-1,3] -> 1 -> 7 -> abs(1-7) -> 6`
  - `[14,20] -> 17 -> 7 -> abs(17-7) -> 10`
  - `[0,14] -> 7 -> 1 -> abs(7-1) -> 6`
- sort letters from the original list by keys
