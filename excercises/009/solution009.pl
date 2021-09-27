% int_to_list_of_digits(+Int, -ListOfDigits)
int_to_list_of_digits(N, [N]) :- N < 10, !.
int_to_list_of_digits(N, Result) :- 
    NMod10 is N mod 10, 
    NBy10 is N // 10,
    int_to_list_of_digits(NBy10, PartialResult),
    append(PartialResult, [NMod10], Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_int_to_list_of_digits(X) :- int_to_list_of_digits(123, X).
% X = [1, 2, 3]


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


% remove_nonmonotonic(+ListOfDigits, -MonotinicListOfDigits)
remove_nonmonotonic([], []).
remove_nonmonotonic([X], [X]).
remove_nonmonotonic([H1, H2|T], [H1|T2]) :- H1 < H2, remove_nonmonotonic([H2|T], T2), !.
remove_nonmonotonic([H1, _|T], [H1|T2]) :- remove_nonmonotonic([H1|T], [H1|T2]).

test_remove_nonmonotonic(X, Y) :- 
	remove_nonmonotonic([1, 5, 7], X),
    remove_nonmonotonic([5, 3, 7], Y).
% X = [1, 5, 7]
% Y = [5, 7]


to_key(X, ListOfDigits, MonotinicListOfDigits, Key) :- 
    int_to_list_of_digits(X, ListOfDigits),
    remove_nonmonotonic(ListOfDigits, MonotinicListOfDigits),
    list_of_digits_to_number(MonotinicListOfDigits, Key).

test_to_key(A1, A2, AKey, B1, B2, BKey, C1, C2, CKey) :-
    to_key(123, A1, A2, AKey),
    to_key(537, B1, B2, BKey),
    to_key(153, C1, C2, CKey).
% A1 = [1, 2, 3],
% A2 = [1, 2, 3],
% AKey = 123,
% B1 = [5, 3, 7],
% B2 = [5, 7],
% BKey = 57,
% C1 = [1, 5, 3],
% C2 = [1, 5],
% CKey = 15


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

test_solve(X) :- solve([123, 537, 153, 162], X).
% X = [153, 162, 537, 123]
