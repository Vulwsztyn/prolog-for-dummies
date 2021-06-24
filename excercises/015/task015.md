Input:

- L - list of ints - e.g. `[164,177,178]`

Algorithm:
- map L to pairs of orignal values and `[]`
  - `164 -> [10,4]`
  - `177 -> [11,1]`
  - `178 -> [11,2]`
- remove elements greater than 9
  - `164 -> [10,4] -> [4]`
  - `177 -> [11,1] -> [1]`
  - `178 -> [11,2] -> [2]`
- join numbers as if they were in radix 10 to get key (I know the example in garbage)
  - `164 -> [10,4] -> [4] -> 4`
  - `177 -> [11,1] -> [1] -> 1`
  - `178 -> [11,2] -> [2] -> 2`
  - `[2,3,4] -> 234`
- sort by key
