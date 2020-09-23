% insert(+NewElement, +SortedList, -ListWithNewElement)
% inserts the element before the first element in the list that is greater or equal to the element
% notice that in oder to work properly to list needs to be sorted, hence the name
% ! needed - found by trial and error, I will explain this when I get it
insert(X,[],[X]).
insert(X,[Y|T],[X,Y|T]) :- X=<Y, !.
insert(X,[Y|T],[Y|NT]) :- X>Y, insert(X,T,NT).

test_insert(X) :- insert(7,[2,4,5,6,8,9],X).


% i_sort(+List, +SortedAccumulator, -ListMergedWithAcc)
% inserts elements of the list one by one to the accumulator (in their correct place, so that the list is still sorted)
% notice that in oder to work properly to accumulator needs to be sorted, hence the name
% ! needed - found by trial and error, I will explain this when I get it
i_sort([],Acc,Acc).
i_sort([H|T],Acc,Sorted) :- insert(H,Acc,NAcc), i_sort(T,NAcc,Sorted), !.

test_i_sort(X) :- i_sort([ 3, 18,  6,  5,  2,  8, 15, 13, 14,  0, 12,  7,  9, 10, 19, 16, 11],[1,  4, 17],X).


% insert_sort(+List, -Sorted)
% runs the i_sort with [] as accumulator
insert_sort(List,Sorted) :- i_sort(List,[],Sorted).

test_insert_sort(X) :- insert_sort([ 3, 18,  6,  5,  2,  8, 15, 13, 14,  0, 12,  7,  9, 10, 19, 16, 11, 1,  4, 17],X).