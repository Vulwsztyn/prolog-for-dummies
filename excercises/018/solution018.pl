% my_sum(+List, -Sum)
% returns sum of list
% ! is not needed as [] doesn't match [H|T]
my_sum([], 0).
my_sum([H|T], N) :- my_sum(T, N1), N is N1 + H.

% it could be written wrong:
% my_sum([H|T], N) :- N is N1 + H, my_sum(T, N1).
% in N is N1 + H both N and N1 would be undefined (order of predicates in the body matters).

test_my_sum(X) :- my_sum([12, 25, 5], X).
% X = 42
 

% my_max(+List, -Max).
my_max([X], X) :- !.
my_max([H|T], H) :- my_max(T, MT), MT < H, !.
my_max([_|T], MT) :- my_max(T, MT).

test_my_max(X) :- my_max([16, 18, 22, 27, 12, 25, 21], X).
% X = 27


% my_length(+List, -Length)
% predicate used to extract head from list
% no ! is needed as there is only one way the predicate can be interpreted (or something like that I don't fully get it either)
% the `stop` (non-recursive) version of this predicate looks like that, because `[]` is the shortest list possible
% N in the recursive version of this predicate is the length of tail of the list which we know is shorter by one element than the current list
my_length([], 0).
my_length([_|T], N1) :- my_length(T, N), N1 is N + 1.

test_my_length(L) :- my_length(['Z', 'i', 'b', 'r', 'o', ', ', ' ', 'T', 'y', ' ', 'k'], L).
% L = 11


% avg (for ctrl+f)
% my_average(+List, -Average)
% returns average of list
% ! is not needed as it is not reccursive
my_average(L, A) :- my_sum(L, S), length(L, Len), A is S / Len.

test_my_average(A, B, C, D, E) :- my_average([16, 18, 22, 27, 12, 25, 21], A),
    my_average([16, 18, 22, 27], B),
    my_average([18, 22, 27, 12], C),
    my_average([22, 27, 12, 25], D),
    my_average([27, 12, 25, 21], E).
% A = 20.142857142857142,
% B = 20.75,
% C = 19.75,
% D = 21.5,
% E = 21.25


% helper(+Value, +List, -RightOfValue, -LeftOfValue, -RightOfValueLength, -LeftOfValueLength)
% splits list into variables named above
helper(V, L, Right, Left, RightLen, LeftLen) :-
	append(Left, [V|Right], L),
    my_length(Left, LeftLen),
    my_length(Right, RightLen),
    !.


% remove_elements_until_value_in_the_middle(+Value, +List, -ListWithValue)
remove_elements_until_value_in_the_middle(V, L, L) :-
    helper(V, L, _, _, RightLen, LeftLen),
    RightLen =:= LeftLen,
    !.
remove_elements_until_value_in_the_middle(V, L, LR) :-
    helper(V, L, Right, Left, RightLen, LeftLen),
    RightLen > LeftLen,
    append(NewRight, [_], Right),
    append(Left, [V|NewRight], L2),
    remove_elements_until_value_in_the_middle(V, L2, LR),
    !.
% I dont need to check if RightLen < LeftLen, because 2 versions above get every other option
% I could if I wanted, but there is no need
remove_elements_until_value_in_the_middle(V, L, LR) :-
    helper(V, L, Right, Left, _, _),
    append([_], NewLeft, Left),
    append(NewLeft, [V|Right], L2),
    remove_elements_until_value_in_the_middle(V, L2, LR).

test_remove_elements_until_value_in_the_middle(X, Y, Z) :-
    remove_elements_until_value_in_the_middle(2, [1, 2, 3], X),
    remove_elements_until_value_in_the_middle(2, [1, 2, 3, 4, 5], Y),
    remove_elements_until_value_in_the_middle(2, [11, 1, 1, 1, 1, 1, 1, 2, 3, 4, 5], Z).

to_key(V, K):-
    my_max(V, Max),
    remove_elements_until_value_in_the_middle(Max, V, NewV),
    my_average(NewV, K).

% pivoting(+Pivot: a, +List: [a], -Lesser: [a], -Greater: [a])
pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :-
    pivoting(P, T, L, G), 
    to_key(H, HKey),
    to_key(P, PKey),
    HKey =< PKey,
    !.
pivoting(P, [H|T], L, [H|G]) :- 
    pivoting(P, T, L, G).


% quick_sort(+List: [a], -SortedList: [a])
quick_sort([], []) :- !.
quick_sort([H|T], Sorted):-
    pivoting(H, T, L, G), 
    quick_sort(L, SortedL), 
    quick_sort(G, SortedG),
    append(SortedL, [H|SortedG], Sorted),
    !.

test_quick_sort(X) :- quick_sort([[1, 2, 3], [1, 2, 1], [1, 2, 1, 1, 1]], X).
% X = [[1, 2, 1, 1, 1], [1, 2, 1], [1, 2, 3]]

solution(X) :- test_quick_sort(X).
