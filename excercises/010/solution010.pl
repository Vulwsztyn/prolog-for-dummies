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


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
%type a and type b can be the same
to_key(X, Y) :- 
    to_binary(X, Binary),
    count_consecutive(Binary, Consecutives),
    list_of_digits_to_number(Consecutives, Y).

%%% from bykey/sort_easy%%%

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


solve(X, Y) :- quick_sort(X, Y).

test_solve(X) :- solve([27, 17, 24, 25, 31, 21], X).
% X = [31, 24, 17, 27, 25, 21]
