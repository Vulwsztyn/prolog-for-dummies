% my_middle(+Interval: [Int, Int], -Middle: Float)
my_middle([A, B], M) :- M is (A+B)/2.

test_my_middle(X, Y) :- my_middle([-3, 5], X), my_middle([-3, 4], Y).
% X = 1,
% Y = 0.5

% is_inside_inclusively(+Elem, +Interval)
% this one is tricky, it doesn't "return" anything it just "is"
is_inside_inclusively(N, [S, G]) :- N >= S, N =< G.

test_is_inside_1('2 is in the interval') :- is_inside_inclusively(2, [2, 4]).
test_is_inside_2('2 is not in the interval') :- not(is_inside_inclusively(2, [3, 6])).


% my_abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.

% version for people who do not remember that ! stops evaluation
% my_abs(X, X) :- X >= 0, !.
% my_abs(X, X2) :- X < 0, X2 is -X.

my_abs_test(X, Y) :- my_abs(5, X), my_abs(-3, Y).
% X = 5,
% Y = 3


% my_length(+List, -Length)
% predicate used to extract head from list
% no ! is needed as there is only one way the predicate can be interpreted (or something like that I don't fully get it either)
% the `stop` (non-recursive) version of this predicate looks like that, because `[]` is the shortest list possible
% N in the recursive version of this predicate is the length of tail of the list which we know is shorter by one element than the current list
my_length([], 0).
my_length([_|T], N1) :- my_length(T, N), N1 is N + 1.

test_my_length(L) :- my_length(['Z', 'i', 'b', 'r', 'o', ', ', ' ', 'T', 'y', ' ', 'k'], L).
% L = 11


my_flatten([], []).
my_flatten([H|T], Result) :-
    my_flatten(T, FT),
    append(H, FT, Result).

test_my_flatten(X) :- my_flatten([[], [1], [2, 3], [3, 4, 5], [4, 5, 6, 7]], X).
% X = [1, 2, 3, 3, 4, 5, 4, 5, 6, 7]


% my_member(+Elem, +List)
% predicate used to check whether the element is in the list
% ! is needed because my_member(1, [1]) would return true form first line and then go on to the next to check
% you are welcome to remove the ! and check yourself
my_member(H, [H|_]) :- !.
my_member(X, [_|T]) :- my_member(X, T).

test_my_member('2 is in the list') :- my_member(2, [1, 2, 2, 3]).
test_my_member2('2 is not in the list') :- not(my_member(2, [1, 3])).


% leave_only_included(+Interval: [2]number, +List: []number, -ListOfIncluded: []number)
leave_only_included(_, [], []).
leave_only_included(N, [H|T], [H|T2]) :- is_inside_inclusively(H, N), leave_only_included(N, T, T2), !.
leave_only_included(N, [_|T], T2) :- leave_only_included(N, T, T2).

test_leave_only_included(X) :- leave_only_included([0, 7], [-4, -1, 2, 4, 5, 7, 8, 9], X).
% X = [2, 4, 5, 7]


% remove_duplicates(+List: []A, -ListWithoutDuplicates: []A)
remove_duplicates([], []).
remove_duplicates([H|T], TR):-
    remove_duplicates(T, TR),
    my_member(H, TR),
    !.
remove_duplicates([H|T], [H|TR]):-
    remove_duplicates(T, TR).

test_remove_duplicates(X) :- remove_duplicates([2, 2, 2, 1, 3, 3, 3, 7, 7, 2, 1, 7, 3, 2, 1, 3, 3, 7], X).
% X = [2, 1, 3, 7]


% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one([], _, []).
remove_one([H|T], H, Filtered) :-
    remove_one(T, H, Filtered),
    !.
remove_one([H|T], E, [H|Filtered]) :-
    H =\= E,
    remove_one(T, E, Filtered).


test_remove_one(X) :- remove_one([6, 2, 6, 1, 6, 3, 6, 7], 6, X).
% X = [2, 1, 3, 7]


% remove_list(+List: [a], +List2: [a], -ListWithoutList2: [a])
remove_list(L, [], L).
remove_list(L, [H|T], LW) :-
    remove_one(L, H, LwithoutH),
    remove_list(LwithoutH, T, LW),
    !.

test_remove_list(X) :- remove_list([4, 5, 8, 9, 5, 2, 4, 0, 4, 2, 5, 7], [4, 5], X).
% X = [8, 9, 2, 0, 2, 7]


% map_to_included(+ListOf Intervals: [][2]number, +List []number, -ListOfIncludedInEachInterval: [][]number)
map_to_included([], _, []).
map_to_included([H|T], L, [HM|TM]) :-
    leave_only_included(H, L, HM),
    map_to_included(T, L, TM)
    .

test_map_to_included(X) :- map_to_included([[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], X).
% X = [[-1, 1], [6], [6, 9, 10], [9, 10]]

% generate_unique_list(+ListOf Intervals: [][2]number, +List []number, -Result: []number)
% Result is a list of elements of List that are is at least one interval of I without duplicates
generate_unique_list(I, L, Result) :-
    map_to_included(I, L, Inc),
    my_flatten(Inc, Flat),
    remove_duplicates(Flat, Result).

test_generate_unique_list(X) :- generate_unique_list([[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], X).
% X = [-1, 1, 6, 9, 10]


to_key(Interval, Intervals, List, Key):-
    generate_unique_list(Intervals, List, U),
    leave_only_included(Interval, List, Inc),
    remove_list(U, Inc, NotInc),
    my_length(NotInc, Key),
    !.

test_to_key(A, B, C, D) :- 
    to_key([-3, 1], [[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], A),
    to_key([3, 7], [[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], B),
    to_key([6, 10], [[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], C),
    to_key([8, 11], [[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], D).
% A = 3
% B = 4,
% C = 2
% D = 3

% min_by_key(+Intervals, +List, +Intervals, -Result)
min_by_key([X], _, _, X).
min_by_key([H|T], L, Intervals, H) :- 
    min_by_key(T, L, Intervals, TMin), 
    to_key(TMin, Intervals, L, TKey), 
    to_key(H, Intervals, L, HK), 
    TKey > HK, 
    !.
min_by_key([_|T], L, Intervals, TMin) :-  
    min_by_key(T, L, Intervals, TMin), 
    !.

test_min_by_key(X) :- min_by_key([[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], [[-3, 1], [3, 7], [6, 10], [8, 11]], X).
% X = [6, 10]


run_solver(I, L, R):-min_by_key(I, L, I, R).

solution(X) :- run_solver([[-3, 1], [3, 7], [6, 10], [8, 11]], [-4, -1, 1, 2, 6, 9, 10, 12], X).
