% my_range(+Start, +End, -Range)
% returns all ints between start and end inclusively
my_range(X, X, []) :- !.
my_range(X, Y, [X|T]) :- X1 is X + 1, my_range(X1, Y, T).

test_my_range(X) :- my_range(-9, 5, X).
% X = [-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4]

% leave_only_divisors(+Number, +ListOfNUmber, -ListOfDivisorsInInputList)
leave_only_divisors(_, [], []).
leave_only_divisors(N, [H|T], [H|T2]) :-
    mod(N, H) =:= 0,
    leave_only_divisors(N, T, T2),
    !.
leave_only_divisors(N, [_|T], T2) :-
    leave_only_divisors(N, T, T2).

test_leave_only_divisors(X) :-
    leave_only_divisors(20, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], X).
% X = [1, 2, 4, 5, 10]

% leave_only_even_or_odd(+Rest(0 for even, 1 for odd), +List, -FilteredList)
leave_only_even_or_odd(_, [], []).
leave_only_even_or_odd(R, [H|T], [H|T2]) :-
    mod(H, 2) =:= R,
    leave_only_even_or_odd(R, T, T2),
    !.
leave_only_even_or_odd(R, [_|T], T2) :-
	leave_only_even_or_odd(R, T, T2).

test_leave_only_even_or_odd(X, Y) :-
    leave_only_even_or_odd(1, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], X),
    leave_only_even_or_odd(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], Y).
% X = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
% Y = [2, 4, 6, 8, 10, 12, 14, 16, 18]


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


to_key(X, Range, Divisors, R, EvenOrOddDivisors, Key) :- 
    my_range(1, X, Range),
    leave_only_divisors(X, Range, Divisors),
    R is mod(X, 2),
    leave_only_even_or_odd(R, Divisors, EvenOrOddDivisors),
    my_sum(EvenOrOddDivisors, Key).

test_to_key(A1, A2, A3, A4, AKey, B1, B2, B3, B4, BKey, C1, C2, C3, C4, CKey, D1, D2, D3, D4, DKey) :-
    to_key(20, A1, A2, A3, A4, AKey),
    to_key(11, B1, B2, B3, B4, BKey),
    to_key(24, C1, C2, C3, C4, CKey),
    to_key(15, D1, D2, D3, D4, DKey).
% A1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
% A2 = [1, 2, 4, 5, 10],
% A3 = 0, 
% A4 = [2, 4, 10],
% AKey = 16,
% B1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
% B2 = [1], 
% B3 = 1, BKey = 1, D3 = 1,
% B4 = [1],
% BKey = 1, 
% C1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
% C2 = [1, 2, 3, 4, 6, 8, 12],
% C3 = 0,
% C4 = [2, 4, 6, 8, 12],
% CKey = 32,
% D1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
% D2 = [1, 3, 5],
% D3 = 1,
% D4 = [1, 3, 5],
% DKey = 9


%%% from by_key/sort_easy%%%

% pivoting(+Pivot: a, +List: [a], -Lesser: [a], -Greater: [a])
pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :-
    pivoting(P, T, L, G), 
    to_key(H, _, _, _, _, HKey),
    to_key(P, _, _, _, _, PKey),
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


solve(X, Y) :- quick_sort(X, Y).

test_solve(X) :- solve([20, 11, 24, 15], X).
% X = [11, 15, 20, 24]
