Input:

- L - list of unique letters - e.g. `[c, m, p]`
- L2 - list of letters - e.g. `[a, b, d, e, r, y, a, k, n, b, z]`

Consts:

- alphabet([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]).

Task:

- output is to be the list with len(L) lists containing all elements of L2 aggregated by which elem of L is closest to them
  - `[[a, a, b, b, d, e], [k, n], [r, y, z]]`

My Algorithm:

- map L to pairs of orignal values and `[]`
  - `c -> [c, []]`
  - `m -> [m, []]`
  - `p -> [p, []]`
- for each element of L2 append it to proper list from previous point
