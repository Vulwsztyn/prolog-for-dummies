% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one_once([], _, []).
remove_one_once([H|T], H, T) :-!.
remove_one_once([H|T], E, [H|Removed]) :-
    remove_one_once(T, E, Removed).

test_remove_one_once(X) :- remove_one_once([6, 2, 6, 1, 6, 3, 6, 7], 6, X).
% X = [2, 6, 1, 6, 3, 6, 7]


% dist(+Point1: [2]number, +Point2: [2]number, -Distance: number)
dist([X1, Y1], [X2, Y2], Dist) :- 
	DX is X1 - X2,
    DY is Y1 - Y2,
    Dist is (DX * DX) + (DY * DY).

test_dist(X, Y) :-
    dist([0, 0], [3, 4], X),
    dist([1, 1], [4, 5], Y).
% X = 25
% Y = 25


% map_to_dist(+Point: [2]number, +Points[][2]number, -DistancesFromPointToPoints: []number)
map_to_dist(_, [], []) :- !.
map_to_dist(X, [H|T], [HD|TD]) :-
    dist(H, X, HD),
    map_to_dist(X, T, TD)
    .

test_map_to_dist(X) :- map_to_dist([3, 6], [[3, 6], [1, 2], [5, 5], [5, 2]], X).
% X = [0, 20, 5, 20]


% my_min(+List, -Min).
my_min([X], X) :- !.
my_min([H|T], H) :- my_min(T, MT), MT > H, !.
my_min([_|T], MT) :- my_min(T, MT).

test_my_min(X) :- my_min([16, 18, 22, 27, 12, 25, 21], X).
% X = 12


% 3rd and 4th are just for debug
to_key(Point, Points, PointsWithoutPoint, Dists, Key) :-
    remove_one_once(Points, Point, PointsWithoutPoint),
    map_to_dist(Point, PointsWithoutPoint, Dists),
    my_min(Dists, Key).

test_to_key(A1, A2, AKey, B1, B2, BKey, C1, C2, CKey, D1, D2, DKey) :-
    to_key([3, 6], [[3, 6], [1, 2], [5, 5], [5, 2]], A1, A2, AKey),
    to_key([1, 2], [[3, 6], [1, 2], [5, 5], [5, 2]], B1, B2, BKey),
	to_key([5, 5], [[3, 6], [1, 2], [5, 5], [5, 2]], C1, C2, CKey),
	to_key([5, 2], [[3, 6], [1, 2], [5, 5], [5, 2]], D1, D2, DKey).
% A1 = [[1, 2], [5, 5], [5, 2]],
% A2 = [20, 5, 20],
% AKey = 5, 
% B1 = [[3, 6], [5, 5], [5, 2]],
% B2 = [20, 25, 16],
% BKey = 16,
% C1 = [[3, 6], [1, 2], [5, 2]],
% C2 = [5, 25, 9],
% CKey = 5,
% D1 = [[3, 6], [1, 2], [5, 5]],
% D2 = [20, 16, 9],
% DKey = 9


% pivoting(+Pivot: a, +List: []a, +List: []a, -Lesser: []a, -Greater: []a)
pivoting(_, _, [], [], []) :- !.
pivoting(P, List, [H|T], [H|L], G) :-
    pivoting(P, List, T, L, G), 
    to_key(H, List, _, _, HKey),
    to_key(P, List, _, _, PKey),
    HKey =< PKey,
    !.
pivoting(P, List, [H|T], L, [H|G]) :- 
    pivoting(P, List, T, L, G).


% quick_sort(+List: []a, -SortedList: []a)
quick_sort([], _, []) :- !.
quick_sort([H|T], List, Sorted):-
    pivoting(H, List, T, L, G), 
    quick_sort(L, List, SortedL), 
    quick_sort(G, List, SortedG),
    append(SortedL, [H|SortedG], Sorted),
    !.


run_quick_sort(X, Y) :- quick_sort(X, X, Y).

solution(X) :- run_quick_sort([[3, 6], [1, 2], [5, 5], [5, 2]], X).
% X = [[5, 5], [3, 6], [5, 2], [1, 2]]
