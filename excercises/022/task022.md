Input:

- L - list of slashes and backslashes - e.g. `[/, /, \, \, \, \, /, /, \, \, \, \, /, /, /, \]`

Algorithm:

- The list represents a graph starting at 0 and going up and down - or staying the same if the sign is opposit to previous). It should be mapped to values that the line is at after each slash
- `[/, /, \, \, \, \, /, /, \, \, \, \, /, /, /, \] -> [1, 2, 2, 1, 0, -1, -1, 0, 0, -1, -2, -3, -3, -2, -1, -1]`
