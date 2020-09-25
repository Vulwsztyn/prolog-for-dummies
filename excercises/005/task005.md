Input:
- L - list of integers - e.g. `[623, 278, 4231, 739, 38]`
    - only constraint is that the number of digits in all the numbers must be odd:
        - `[623, 278, 4231, 739, 38] -> 3 + 3 + 4 + 3 + 2 = 1`

Algorithm:
- map the list of ints to the list of lists of digits corresponding to each int
    - `[623, 278, 4231, 739, 38] -> [[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]]`
- flatten the list
    - `[[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]] -> [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8]`
- rotate the flat list so that the max element (`9`) is in the middle
    - `[6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8] -> [8, 4, 2, 3, 1, 7, 3, 9, 3, 8, 6, 2, 3, 2, 7]`
- nest the resulting list so that it has the same structure as list from the first step:
    - `[8, 4, 2, 3, 1, 7, 3, 9, 3, 8, 6, 2, 3, 2, 7] -> [[8, 4, 2], [3, 1, 7], [3, 9, 3, 8], [6, 2, 3], [2, 7]]`
- map the resulting list of lists of digits to numbers
    - `[[8, 4, 2], [3, 1, 7], [3, 9, 3, 8], [6, 2, 3], [2, 7]] -> [842, 317, 3938, 623, 27]`

