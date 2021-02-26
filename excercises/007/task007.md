Input:
- L - list of integers - e.g. `[21, 23, 29, 33]`

Algorithm:
- map the list of ints to the list of lists of digits corresponding to binary representation of each int
    - `21 -> [1, 0, 1, 0, 1]`
    - `23 -> [1, 0, 1, 1, 1]`
    - `29 -> [1, 1, 1, 0, 1]`
    - `33 ->  [1, 0, 0, 0, 0, 1]`
- move ones in each binary number to the left creating new binary numbers
    - `[1, 0, 1, 0, 1] -> [1, 1, 1, 0, 0]`
    - `[1, 0, 1, 1, 1] -> [1, 1, 1, 1, 0]`
    - `[1, 1, 1, 0, 1] -> [1, 1, 1, 1, 0]`
    - `[1, 0, 0, 0, 0, 1] -> [1, 1, 0, 0, 0, 0]`
- append ones or zeros to each binary numbers so that they have the same number of ones and zeros
    - `[1, 1, 1, 0, 0] -> [1, 1, 1, 0, 0, 0]`
    - `[1, 1, 1, 1, 0] -> [1, 1, 1, 1, 0, 0, 0, 0]`
    - `[1, 1, 1, 1, 0] -> [1, 1, 1, 1, 0, 0, 0, 0]`
    - `[1, 1, 0, 0, 0, 0]  -> [1, 1, 0, 0, 0, 0, 1, 1]`
- convert each numebr from the previous step to decimal:
    - `[1, 1, 1, 0, 0, 0] -> 56`
    - `[1, 1, 1, 1, 0, 0, 0, 0] -> 240`
    - `[1, 1, 1, 1, 0, 0, 0, 0] -> 240`
    - `[1, 1, 0, 0, 0, 0, 1, 1] -> 195`
- absolute difference between the original numbers and numbers from the previous step is the key
    - `abs(21-56) = 35`
    - `abs(23-240) = 217`
    - `abs(29-240) = 211`
    - `abs(33-195) = 162`
- find a number with maximal key