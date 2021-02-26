Input:
- L - list of intervals - e.g. `[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]]`

Task:
- find integer that is inside of most intervals and on the verge of none

Algorithm:
- get the domain of all intervals (i.e `[min,max]`):
    - `[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]] -> [-9,5]`
- find all interegs in the domain:
    - `[-9,5]->  [-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]`
- flatten the list of intervals;
    - `[[-6, 1], [-1, 3], [-5, 2], [-3, 5], [-9, -2], [-8, -6]] -> [-6, 1, -1, 3, -5, 2, -3, 5, -9, -2, -8, -6]`
- remove elements of the flattened list of intervals from the list of integers in the domain:
    - `[-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5] - [-6, 1, -1, 3, -5, 2, -3, 5, -9, -2, -8, -6] -> [-7, -4, 0, 4]`
- for each number count how many intervals include it:
    - `-7 -> 2`
    - `-4 -> 3`
    - `0 -> 4`
    - `4 - 1`
- get max of them