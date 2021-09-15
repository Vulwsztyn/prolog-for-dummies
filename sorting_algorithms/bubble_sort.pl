% bubble(+CurrentMax, +List, -ListWithoutMax, -Max)
% i think the parameters are self-explanatory here
% ! needed, because input args are the same in 2nd and 3rd line
bubble(X, [], [], X).
bubble(X, [Y|T], [Y|NT], Max) :- X>Y, bubble(X, T, NT, Max), !.
bubble(X, [Y|T], [X|NT], Max) :- X=<Y, bubble(Y, T, NT, Max).

% notice that the third line could be 
% bubble(X, [Y|T], [X|NT], Max) :- bubble(Y, T, NT, Max).
% because if X>Y it gets stopped by the ! in the 2nd line

% it is run as in 
% b_sort([H|T], Acc, Sorted) :- bubble(H, T, NT, Max), b_sort(NT, [Max|Acc], Sorted), !.
% meaning that the current max is the element of the list upon which the bubbling is performed

test_bubble(N, M) :- bubble(3, [18,  6,  5,  2,  8, 15, 13, 14,  0, 12,  7,  9, 10, 19, 16, 11], N, M).
% M = 19,
% N = [3, 6, 5, 2, 8, 15, 13, 14, 0, 12, 7, 9, 10, 18, 16, 11]


% b_sort(+List, +SortedAccumulator, -ListMergedWithAcc)
% prepends the accumulator with maximal element of the list and runs self again without the max element
% notice that in oder to work properly to accumulator needs to be sorted and all elements of the accumulator need to be greater or equal to max(List), hence the name
% ! needed - found by trial and error, I will explain this when I get it
b_sort([], Acc, Acc).
b_sort([H|T], Acc, Sorted) :- bubble(H, T, NT, Max), b_sort(NT, [Max|Acc], Sorted), !.

test_b_sort(S) :- b_sort([ 3, 6, 5, 2, 8, 15, 13, 14, 0, 12, 7, 9, 10, 11, 1, 4], [16, 17, 18, 19], S).
% S = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]


% bubble_sort(+List, -Sorted)
% runs the b_sort with [] as accumulator
bubble_sort(List, Sorted):-b_sort(List, [], Sorted).

test_bubble_sort(S).
% S = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]