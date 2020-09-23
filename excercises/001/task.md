Input:
- L - list of unique integers - e.g. [16, 18, 22, 27, 12, 25, 21]
- N - integer of value not greater than the length of the list - e.g. 4

Algorithm:
- make a list (LS) of all sublist of length N composed of consecutive elements of list
    - [[16, 18, 22, 27],[18, 22, 27, 12],[22, 27, 12, 25],[27, 12, 25, 21]]
- for each list make a complement list from L:
    - [16, 18, 22, 27] -> [12, 25, 21]
    - [18, 22, 27, 12] -> [16, 25, 21]
    - [22, 27, 12, 25] -> [16, 18, 21]
    - [27, 12, 25, 21] -> [16, 18, 22]
- fore each complement calculate the average
    - [12, 25, 21] -> 20.75
    - [16, 25, 21] -> 19.75
    - [16, 18, 21] -> 21.5
    - [16, 18, 22] -> 21.25
- calculate the average of L
    - [16, 18, 22, 27, 12, 25, 21] -> 20.142857142857142
- find the element of the first list (LS) for whom the complement has the closest average to the original average - this value will be the Key.