Input:
- L - list of unique integers - e.g. `[15,22,25,33]`

Algorithm:
- for each number find the list of integers that squared sum up to the number:
    - `15 -> 3^2 + 2^2 + 1^2 + 1^2`
    - `22 -> 4^2 + 2^2 + 1^2 + 1^2`
    - `25 -> 5^2`
    - `33 -> 5^2 + 2^2 + 2^2`
- calculate average of each list generated in the previous step, this will be the key
    - `15 -> 3^2 + 2^2 + 1^2 + 1^2 -> 1.75`
    - `22 -> 4^2 + 2^2 + 1^2 + 1^2 -> 2`
    - `25 -> 5^2 -> 5`
    - `33 -> 5^2 + 2^2 + 2^2 -> 3`
- find element that gives max key

