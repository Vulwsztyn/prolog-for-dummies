Input:

- L - list of integers - e.g. `[20,11,24,15]`

Algorithm:

- for each element of L create a list of divisors lesser then the element (order does not matter)
  - `20 -> [1,2,4,5,10]`
  - `11 -> [1]`
  - `24 -> [1,2,3,4,6,8,12]`
  - `15 -> [1,3,5]`
- leave only even divisors if the element was even and odd if it was odd
  - `20 -> [1,2,4,5,10] -> [2,4,10] `
  - `11 -> [1] -> [1]`
  - `24 -> [1,2,3,4,6,8,12] -> [2,4,6,8,12]`
  - `15 -> [1,3,5] -> [1,3,5]`
- sum the filtered divisors to get the key
- sort numbers from the original list by keys
