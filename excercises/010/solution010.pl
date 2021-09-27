% to_binary(+Int, -ListOfBits)
to_binary(X, [X]) :- X < 2, !.
to_binary(N, Result) :- 
    NMod10 is N mod 2, 
    NBy10 is N // 2,
    to_binary(NBy10, PartialResult),
    append(PartialResult, [NMod10], Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_to_binary(X) :- to_binary(12345, X).
% X = [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1]


% list_of_digits_to_number(+ListOfDigits, -Number)
list_of_digits_to_number([], 0).
list_of_digits_to_number(L, N) :-
    append(Init, [Last], L),
	list_of_digits_to_number(Init, N1),
    N is N1 * 10 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_list_of_digits_to_number(X) :- list_of_digits_to_number([6, 2, 3], X).
% X = 623


% count_consecutive(+List, -OutpuList)
% I know the singatre and name is not the best :(
count_consecutive([], []).
count_consecutive([_], [1]).
count_consecutive([H, H|T], [HOutput|TOutput]) :-
    count_consecutive([H|T], [HOutput1|TOutput]),
    HOutput is HOutput1 + 1,
    !.
count_consecutive([_, H|T], [1|TOutput]) :-
    count_consecutive([H|T], TOutput).

test_count_consecutive(X, Y) :- 
    count_consecutive([1, 1, 0, 1, 1], X),
    count_consecutive([1, 0, 0, 0, 1], Y).
% X = [2, 1, 2],
% Y = [1, 3, 1]


to_key(X, Binary, Consecutives, Key) :- 
    to_binary(X, Binary),
    count_consecutive(Binary, Consecutives),
    list_of_digits_to_number(Consecutives, Key).

test_to_key(A1, A2, AKey, B1, B2, BKey, C1, C2, CKey) :-
    to_key(27, A1, A2, AKey),
    to_key(17, B1, B2, BKey),
    to_key(24, C1, C2, CKey).
% A1 = [1, 1, 0, 1, 1],
% A2 = [2, 1, 2],
% AKey = 212,
% B1 = [1, 0, 0, 0, 1],
% B2 = [1, 3, 1],
% BKey = 131,
% C1 = [1, 1, 0, 0, 0],
% C2 = [2, 3],
% CKey = 23


%%% from bykey/sort_easy%%%

% pivoting(+Pivot: a, +List: [a], -Lesser: [a], -Greater: [a])
pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :-
    pivoting(P, T, L, G), 
    to_key(H, _, _, HKey),
    to_key(P, _, _, PKey),
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

test_solve(X) :- solve([27, 17, 24, 25, 31, 21], X).
% X = [31, 24, 17, 27, 25, 21]
