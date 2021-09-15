% squeeze_consecutive(+List, -OutpuList)
% remove_consecuitve (do ctrl+f)
% I know the singatre and name is not the best :(
squeeze_consecutive([], []).
squeeze_consecutive([_], [1]).
squeeze_consecutive([H, H|T], TOutput) :-
    squeeze_consecutive([H|T], TOutput),
    !.
squeeze_consecutive([H1, H|T], [H1|TOutput]) :-
    squeeze_consecutive([H|T], TOutput).

test_squeeze_consecutive(X, Y) :- 
    squeeze_consecutive([1, 1, 0, 1, 1], X),
    squeeze_consecutive([1, 0, 0, 0, 1], Y).
% X = [1, 0, 1],
% Y = [1, 0, 1]


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


% from_binary(+ListOfBits, -Number)
from_binary([], 0).
from_binary(L, N) :-
    append(Init, [Last], L),
	from_binary(Init, N1),
    N is N1 * 2 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_binary(X) :- from_binary([1, 0, 1, 0, 0, 1, 1, 0, 1, 0], X).
% X = 666


to_key(V, K) :-
    to_binary(V, B),
    squeeze_consecutive(B, S),
    from_binary(S, K).

test_to_key(X) :- to_key(11, X).
% X = 5

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

test_quick_sort(X) :- quick_sort([21, 15, 11], X).
% X = [15, 11, 21]

solution(X) :- test_quick_sort(X).
