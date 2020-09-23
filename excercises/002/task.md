Input:
- L - list of unique integers - e.g. [16, 18, 22, 27, 12, 25, 21, 13]

Algorithm:
- make a list (LS) of all sublist of length 2 composed of elements of list in sych a way that: first is paired with ultimate, second with penultimate, third with antepenultimate, forth with preantepenultimate, and so on and so forth
    - [[16, 13], [18, 21], [22, 25], [27, 12]]
- for each list make a complement list from L:
    - [16, 13] -> [18, 22, 27, 12, 25, 21]
    - [18, 21] -> [16, 22, 27, 12, 25, 13]
    - [22, 25] -> [16, 18, 27, 12, 21, 13]
    - [27, 12] -> [16, 18, 22, 25, 21, 13]
- fore each complement calculate the average
    - [18, 22, 27, 12, 25, 21] -> 20.833333333333332
    - [16, 22, 27, 12, 25, 13] -> 19.166666666666668
    - [16, 18, 27, 12, 21, 13] -> 17.833333333333332
    - [16, 18, 22, 25, 21, 13] -> 19.166666666666668
- calculate the average of L
    - [16, 18, 22, 27, 12, 25, 21, 13] -> 19.25
- find the element of the first list (LS) for whom the complement has the closest average to the original average - this value will be the Key. If multipleresult in the same key return any.