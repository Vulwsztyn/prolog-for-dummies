
neg(X, Y) :- 
    Y is -X,
    !.

% Map

my_map([], []).
my_map([H|T], [MH|MT]) :- 
    neg(H, MH),
    my_map(T, MT).

test_my_map(X) :- my_map([1, 2, -3], X).
% X = [-1, -2, 3]




is_even(X) :- mod(X, 2) =:= 0.

% Filter

my_filter([], []).
my_filter([H|T], [H|FT]) :-
          is_even(H),
          my_filter(T, FT),
          !.
my_filter([_|T], FT) :- my_filter(T, FT).

test_my_filter(X) :- my_filter([1, 2, 3, 4, 5, -6, 7, -8, 9, 0, -0], X).
% X = [2, 4, -6, -8, 0, 0]


my_sum_two(A, B, C) :- C is A + B.

% Reduce

my_reduce([], Acc, Acc).
my_reduce([H|T], Acc, Result) :-
    my_sum_two(Acc, H, NewAcc),
    my_reduce(T, NewAcc, Result).

test_my_reduce(X) :- my_reduce([1, 2, 3, 4, 5, 6], 0, X).
% X = 21


my_length([], 0).
my_length([_|T], N1) :- my_length(T, N), N1 is N + 1.

% Nth

my_nth(N, List, H) :-
    append(L1, [H|_], List),
    my_length(L1, N),
    !.

test_my_nth(X, Y, Z) :-
    my_nth(0, [123, 456, 789], X),
    my_nth(1, [123, 456, 789], Y),
	my_nth(2, [123, 456, 789], Z).

% X = 123
% Y = 456
% Z = 789

% Flatten

my_flatten([], []).
my_flatten([H|T], Result) :-
    my_flatten(T, FT),
    append(H, FT, Result),
    !.
% optional enables flattening list of lists and elements intermixed
% ! only needed if this is the case else just use 2 upper without !
my_flatten([H|T], [H|FT]) :-
    my_flatten(T, FT).

% ! only needed if next version of term required

test_my_flatten(X) :- my_flatten([[], [1], [2, 3], [3, 4, 5], [4, 5, 6, 7]], X).
% X = [1, 2, 3, 3, 4, 5, 4, 5, 6, 7]
test_my_flatten(X) :- my_flatten([2, [1], [2, 3], [3, 4, 5], [4, 5, 6, 7], 8], X).
% X = [2, 1, 2, 3, 3, 4, 5, 4, 5, 6, 7, 8]

% my_reverse(+List, -reversedList).
my_reverse([], []).
my_reverse([H|T], L) :- my_reverse(T, L1), append(L1, [H], L).

test_reverse(X) :- my_reverse([1, 2, 3, 4], X).
% X = [4, 3, 2, 1]

% my_reverse(+Length: number, +List: []a, -TakenList: []a).
my_take(0, _, []) :- !.
my_take(_, [], []) :- !.
my_take(N, [H|T], [H|R]) :- N > 0, N1 is N - 1, my_take(N1, T, R).

test_my_take(X, Y) :- 
    my_take(3, [1, 2, 3, 4, 5, 6, 7, 8], X),
    my_take(20, [1, 2, 3, 4, 5, 6, 7, 8], Y).
% X = [1, 2, 3],
% Y = [1, 2, 3, 4, 5, 6, 7, 8].
