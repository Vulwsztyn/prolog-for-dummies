Input:

- L - list of points - e.g. `[[3, 6], [1, 2], [5, 5], [5, 2]]`

Algorithm:

- for each point in L find the minimal distance to other point of L to get key:
    - `[3, 6] -> [3, 6] -> 0`
    - `[1, 2] -> [3, 6] -> 1`
    - `[5, 5] -> [3, 6] -> 2`
    - `[5, 2] -> [3, 6] -> 3`
- sort L by the key

Note: I'm using distange squared as I don't want to calculate the square root.