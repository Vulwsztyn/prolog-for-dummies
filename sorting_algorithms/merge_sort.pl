% merge(+SortedList1, +SortedList2, -MergedLists)
% merges 2 sorted lists in a way that the result is still sorted
% ! needed in the 1st line as merge([], [], X). would match 1st and 2nd line
% ! not needed in the 2nd line as merge(L, [], X). wouldn't match 3rd and 4th (because [] doesn't match [Y|T2], because [Y|T2] is a list of at least one elem)
% ! needed in 3rd line as value check is performed inside the body and merge([1], [2], X) would match 3rd and 4th
% ! not needed in 4th line - not sure why
merge([], L, L) :- !.
merge(L, [], L).
merge([X|T1], [Y|T2], [X|T]) :- X=<Y, merge(T1, [Y|T2], T), !.
merge([X|T1], [Y|T2], [Y|T]) :- merge([X|T1], T2, T).

% I omitted Y<X in the 4th line but it could as well be written:
%merge([X|T1], [Y|T2], [Y|T]) :- X>Y, merge([X|T1], T2, T).

test_merge(X) :- merge([1, 3, 5, 7, 9, 11], [2, 4, 6, 8, 10, 12], X).
% X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

% halve(+List, -FirstHalf, -SecondHalf)
% divides the list into 2 halves
% first we use append which generates all possible options of lists that concatenated would give the input list
% then we check whether the length of the lists outputed by append is equal (or almost equal)
% i.e. we are using append as append(-List1, -List2, +List), e.g. append(A, B, [1, 2, 3]).
% version for list with even length:
halve(L, L1, L2) :- append(L1, L2, L), length(L1, Len1), length(L2, Len2), Len1 =:= Len2, !.
% version for list with odd length:
halve(L, L1, L2) :- append(L1, L2, L), length(L1, Len1), length(L2, Len2), Len1 + 1 =:= Len2, !.

test_halve(X, Y) :- halve([1, 2, 3, 4, 5, 6, 7, 8], X, Y).
% X = [1, 2, 3, 4],
% Y = [5, 6, 7, 8]
test_halve_2(X, Y) :- halve([1, 2, 3, 4, 5, 6, 7, 8, 9], X, Y).
% X = [1, 2, 3, 4],
% Y = [5, 6, 7, 8, 9]


% merge_sort(+List, -SortedList)
% halves the List performes self of halved lists and merges the resulting lists preserving order
% second line is needed as [1] halved gives [1], and [] i.e. one of the results is itself so the recursion would never stop
% ! needed - as [] and [X] math List
merge_sort([], []) :- !.    
merge_sort([X], [X]) :- !.   
merge_sort(List, Sorted):-
    halve(List, L1, L2),     
    merge_sort(L1, Sorted1),
    merge_sort(L2, Sorted2),  
    merge(Sorted1, Sorted2, Sorted). 
    
test_merge_sort(X) :- merge_sort([ 3, 18,  6,  5,  2,  8, 15, 13, 14,  0, 12,  7,  9, 10, 19, 16, 11, 1, 4, 17], X).
% X = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
