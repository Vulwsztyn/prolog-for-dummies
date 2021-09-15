Input:

- L - list of letters - e.g. `[a, j, n, t, c, o, g]`

Consts:

- alphabet([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]).

Algorithm:

- for each element of L find another element of L that is closest to it in alphabet
  - `a -> c`
  - `j -> g`
  - `n -> o`
  - `t -> o`
  - `c -> a`
  - `o -> n`
  - `g -> j`
- map each pair from the previous point to difference between indices of its elements in alphabet to get key
  - `a -> c -> 2`
  - `j -> g -> 3`
  - `n -> o -> 1`
  - `t -> o -> 5`
  - `c -> a -> 2`
  - `o -> n -> 1`
  - `g -> j -> 3`
- sort letters from the original list by keys

Alternative Algorithm (used in code):

- map each element of L to it's index in alphabet
  - `a -> 0`
  - `j -> 9`
  - `n -> 13`
  - `t -> 19`
  - `c -> 2`
  - `o -> 14`
  - `g -> 6`
- for each element map L/{this element} to index differences from it
  - `a -> 0 -> [9, 13, 19, 2, 14, 6]`
  - `j -> 9 -> [9, 4, 10, 7, 5, 3]`
  - `n -> 13 -> [13, 4, 6, 11, 1, 7]`
  - `t -> 19 -> [19, 10, 6, 17, 5, 13]`
  - `c -> 2 -> [2, 7, 11, 17, 12, 4]`
  - `o -> 14 -> [9, 4, 10, 7, 5, 3]`
  - `g -> 6 -> [13, 4, 6, 11, 1, 7]`
- map each elem of L to min from lists from previous step to gte keys
- map each pair from the previous point to difference between indices of its elements in alphabet to get key
  - `a -> 2`
  - `j -> 3`
  - `n -> 1`
  - `t -> 5`
  - `c -> 2`
  - `o -> 1`
  - `g -> 3`
- sort letters from the original list by keys
