% my_count(+Elem: a, +List: [a], -NumberOfOccurences: Int)
my_count(_, [], 0).
my_count(H, [H|T], N) :-
    my_count(H, T, N1),
    N is N1 + 1,
    !.
my_count(X, [_|T], N) :-
    my_count(X, T, N).

test_my_count(X) :- my_count(5, [6, 7, 5, 6, 7, 5, 6, 7, 6, 5], X).
% X = 3


% map_to_counts(+ListOfElems: [a], +List: [a], -CountsOfElemsInList: [Int])
map_to_counts([], _, []).
map_to_counts([H|T], L, [HM|TM]) :- 
    my_count(H, L, HM), 
    map_to_counts(T, L, TM),
    !.

test_map_to_counts(A, B, C, D, E) :- 
    map_to_counts([6, 2, 3], [2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8], A),
    map_to_counts([2, 7, 8], [6, 2, 3, 4, 2, 3, 1, 7, 3, 9, 3, 8], B),
    map_to_counts([4, 2, 3, 1], [6, 2, 3, 2, 7, 8, 7, 3, 9, 3, 8], C),
    map_to_counts([7, 3, 9], [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 3, 8], D),
    map_to_counts([3, 8], [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9], E).
% A = [0, 2, 3],
% B = [2, 1, 1],
% C = [0, 2, 3, 0],
% D = [1, 3, 0],
% E = [3, 1],


% int_to_list_of_digits(+Int: Int, -ListOfDigits: [Int])
int_to_list_of_digits(N, [N]) :- N < 10, !.
int_to_list_of_digits(N, Result) :- 
    NMod10 is N mod 10, 
    NBy10 is N // 10,
    int_to_list_of_digits(NBy10, PartialResult),
    append(PartialResult, [NMod10], Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_int_to_list_of_digits(X) :- int_to_list_of_digits(123, X).
% X = [1, 2, 3]


% map_to_lists_of_digits(+List: [Int], -ListOfListsOfDigits: [[Int]])
map_to_lists_of_digits([], []).
map_to_lists_of_digits([H|T], [HM|TM]) :-
    map_to_lists_of_digits(T, TM),
    int_to_list_of_digits(H, HM),
    !.

test_map_to_lists_of_digits(A, B, C, D, E) :- 
    map_to_lists_of_digits([278, 4231, 739, 38], A),
    map_to_lists_of_digits([623, 4231, 739, 38], B),
    map_to_lists_of_digits([623, 278, 739, 38], C),
    map_to_lists_of_digits([623, 278, 4231, 38], D),
    map_to_lists_of_digits([623, 278, 4231, 739], E).
% A = [[2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]],
% B = [[6, 2, 3], [4, 2, 3, 1], [7, 3, 9], [3, 8]],
% C = [[6, 2, 3], [2, 7, 8], [7, 3, 9], [3, 8]],
% D = [[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [3, 8]],
% E = [[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9]],


% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one([], _, []).
remove_one([H|T], H, Filtered) :-
    remove_one(T, H, Filtered),
    !.
remove_one([H|T], E, [H|Filtered]) :-
    H =\= E,
    remove_one(T, E, Filtered).

test_remove_one(A, B, C, D, E) :- 
    remove_one([623, 278, 4231, 739, 38], 623, A),
    remove_one([623, 278, 4231, 739, 38], 278, B),
    remove_one([623, 278, 4231, 739, 38], 4231, C),
    remove_one([623, 278, 4231, 739, 38], 739, D),
    remove_one([623, 278, 4231, 739, 38], 38, E).
% A = [278, 4231, 739, 38],
% B = [623, 4231, 739, 38],
% C = [623, 278, 739, 38],
% D = [623, 278, 4231, 38],
% E = [623, 278, 4231, 739]


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


% flatten(+ListOfLists: [[a]], -FlatList: [a])
my_flatten([], []).
my_flatten([H|T], R) :-
    flatten(T, R1),
    append(H, R1, R).

test_my_flatten(A, B, C, D, E) :- 
    my_flatten([[2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]], A),
    my_flatten([[6, 2, 3], [4, 2, 3, 1], [7, 3, 9], [3, 8]], B),
    my_flatten([[6, 2, 3], [2, 7, 8], [7, 3, 9], [3, 8]], C),
    my_flatten([[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [3, 8]], D),
    my_flatten([[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9]], E).
% A = [2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8],
% B = [6, 2, 3, 4, 2, 3, 1, 7, 3, 9, 3, 8],
% C = [6, 2, 3, 2, 7, 8, 7, 3, 9, 3, 8],
% D = [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 3, 8],
% E = [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9],


% to_key(+Ele: Int, +WholeList: [Int], -Key: Float)
to_key(E, L, LF, ED, LLD, LD, LC, K) :-
    remove_one(L, E, LF),
    int_to_list_of_digits(E, ED),
    map_to_lists_of_digits(LF, LLD),
    my_flatten(LLD, LD),
    map_to_counts(ED, LD, LC),
    my_average(LC, K).


test_to_key(LF, ED, LLD, LD, LC, K) :- 
    to_key(623, [623, 278, 4231, 739, 38], LF, ED, LLD, LD, LC, K).
% LF = [278, 4231, 739, 38],
% ED = [6, 2, 3],
% LLD = [[2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]]
% LD = [2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8],
% LC = [0, 2, 3],
% K = 1.6666666666666667,


% min_by_key(+List, -MinByKey)
min_by_key([X], _, X).
min_by_key([H|T], L, H) :- 
    min_by_key(T, L, TMin), 
    to_key(TMin, L, _, _, _, _, _, TKey), 
    to_key(H, L, _, _, _, _, _, HK), 
    TKey > HK, 
    !.
min_by_key([_|T], L, TMin) :-  
    min_by_key(T, L, TMin), 
    !.

test_min_by_key(X) :- min_by_key([623, 278, 4231, 739, 38], [623, 278, 4231, 739, 38], X).
% X = 4231


solve(X, R) :- min_by_key(X, X, R).

test_solve(X) :- solve([623, 278, 4231, 739, 38], X).
% X = 4231
