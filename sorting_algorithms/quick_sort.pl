% pivoting(+Pivot, +List, -Lesser, -Greater)
% returns divides the list into 2 lists one contating elements lesser than (or equal to) the pivot and the other greater
% ! is not needed as there is no differance in the input parameters of the predicate 
%   and the value check is performed after "going into" the predicates body
pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :- H=<P, pivoting(P, T, L, G), !.
pivoting(P, [H|T], L, [H|G]) :- H>P, pivoting(P, T, L, G).
% lista[0]
% lista[1:]
% to better explain that the order of lines defines where to put the !
% here is the same predicate with the second and third line switched
% pivoting(_, [], [], []).
% pivoting(H, [X|T], L, [X|G]) :- X>H, pivoting(H, T, L, G), !.
% pivoting(H, [X|T], [X|L], G) :- X=<H, pivoting(H, T, L, G).

test_pivoting(L, G) :- pivoting(10, [ 3, 18, 6, 5, 2, 8, 15, 13, 14, 0, 12, 7, 9, 10, 19, 16, 11, 1, 4, 17], L, G).
% G = [18, 15, 13, 14, 12, 19, 16, 11, 17]
% L = [3, 6, 5, 2, 8, 0, 7, 9, 10, 1, 4]

% as you can see the pivtiong preserves order which has no implications to us, 
% but is logical when you understand the implementation


% quick_sort(+List, -SortedList)
% sorts the list
% first it chooses the pivot (first element) 
% then it divides the rest of the list into elements 2 lists (less or equal than the pivot and the rest) using pivoting predicate
% then it recursively sorts both lists
% finally it concatenates the sorted lists with pivot inbetween 
% (as we know it is greater than or equal to the greates elements of the first list and less than the least element of the second list)
% both ! are needed I'm not now  sure why but I checked it and the interpreter tried to find other fitting options
quick_sort([], []) :- !.
quick_sort([H|T], Sorted):-
    pivoting(H, T, L, G), 
    quick_sort(L, SortedL), 
    quick_sort(G, SortedG),
    append(SortedL, [H|SortedG], Sorted),
    !.

test_quick_sort(S) :- quick_sort([ 3, 18,  6,  5,  2,  8, 15, 13, 14,  0, 12,  7,  9, 10, 19, 16, 11, 1, 4, 17], S). 
% S = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
