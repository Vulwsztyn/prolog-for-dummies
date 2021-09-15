alphabet([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]).


% idx(+Elem, +List, -IndexOfElemInList)
idx(H, [H|_], 0) :- !.
idx(H, [_|T], N) :-
    idx(H, T, N1),
    N is N1 + 1.

test_idx(X) :- idx(c, [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z], X).
% X = 2


% my_abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.

my_abs_test(X, Y) :- my_abs(5, X), my_abs(-3, Y).
% X = 5,
% Y = 3
 

% map_to_second(+ListOfPairs, -ListOfSecondElements)
map_to_second([], []).
map_to_second([[_, H]|T], [H|TF]) :- map_to_second(T, TF).
test_map_to_second(X) :- map_to_second([[-6, 1], [-1, 3], [-5, 2], [-3, 5], [-9, -2], [-8, -6]], X).
% X = [1, 3, 2, 5, -2, -6]


% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one_once([], _, []).
remove_one_once([H|T], H, T) :-!.
remove_one_once([H|T], E, [H|Removed]) :-
    remove_one_once(T, E, Removed).


test_remove_one_once(X) :- remove_one_once([6, 2, 6, 1, 6, 3, 6, 7], 6, X).
% X = [2, 6, 1, 6, 3, 6, 7]


% to_pair_with_empty_list(+Elem, -List)
% I guess the code is self explanatory
to_pair_with_empty_list(X, [X, []]).

test_to_pair_with_empty_list(X) :- to_pair_with_empty_list("dupa", X).
% X = ["dupa", []]


% I really hope it's self explanatory (look at test)
map_to_paits_with_empty_lists([], []).
map_to_paits_with_empty_lists([H|T], [H2|T2]) :-
    to_pair_with_empty_list(H, H2),
    map_to_paits_with_empty_lists(T, T2).

test_map_to_paits_with_empty_lists(X) :- map_to_paits_with_empty_lists([c, m, p], X).
% X = [[c, []], [m, []], [p, []]]


% distance_by_alphabet(+A, +B, -Distance)
distance_by_alphabet(A, B, D) :-
    alphabet(Alpha),
	idx(A, Alpha, IA),
    idx(B, Alpha, IB),
    Diff is IA - IB,
    my_abs(Diff, D).

test_distance_by_alphabet(X) :- distance_by_alphabet(a, c, X).
% X = 2
 

% find_closest_by_idx_in_alphabet(+List: []char, +Elem: char, -Distance: Int, -Closest: char)
find_closest_by_idx_in_alphabet([X], Elem, Distance, X) :-
    distance_by_alphabet(X, Elem, Distance).
find_closest_by_idx_in_alphabet([H|T], Elem, Dist, H) :-
    find_closest_by_idx_in_alphabet(T, Elem, DistT, _),
    distance_by_alphabet(H, Elem, Dist),
    Dist < DistT,
    !.
find_closest_by_idx_in_alphabet([_|T], Elem, Dist, Closest) :-
    find_closest_by_idx_in_alphabet(T, Elem, Dist, Closest).

test_find_closest_by_idx_in_alphabet(X, Y) :- find_closest_by_idx_in_alphabet([e, d, c, g, j], a, X, Y).
% X = 2,
% Y = c


% append_to_list_by_key(+Value: char, +Key: char, +InputList: [][char, []int], -OutputList: [][char, []int])
append_to_list_by_key(_, _, [], []).
append_to_list_by_key(V, K, [[K, ListK]|T], [[K, ListKwithV]|T2]) :-
    append(ListK, [V], ListKwithV),
	append_to_list_by_key(V, K, T, T2),
    !.
append_to_list_by_key(V, K, [H|T], [H|T2]) :-
	append_to_list_by_key(V, K, T, T2).

test_append_to_list_by_key(X) :- append_to_list_by_key(666, b, [[a, [1, 2, 3]], [b, [12]], [c, []]], X).
% X = [[a, [1, 2, 3]], [b, [12, 666]], [c, []]]
%                               ^^^


%run_solver( +LWithLists: [][char, []char], +L2: []char
% LWithLists - e.g. [[a, [b, c, d]], [o, [p, q]], [z, []]]
% L2 from input
run_solver(_, [], Dict, Dict) :- !.
run_solver(L, [H|T], Dict, Dict3) :-
    find_closest_by_idx_in_alphabet(L, H, _, Closest),
    run_solver(L, T, Dict, Dict2),
    append_to_list_by_key(H, Closest, Dict2, Dict3),
    !.
test_run_solver(X) :- run_solver([c, m, p], [a, b, d, e, r, y, a, k, n, b, z], [[c, []], [m, []], [p, []]], X).
% X = [[c, [b, a, e, d, b, a]], [m, [n, k]], [p, [z, y, r]]]

solver(L, L2, R) :-
    map_to_paits_with_empty_lists(L, LwithEmpty),
    run_solver(L, L2, LwithEmpty, R2),
    map_to_second(R2, R).

test_solver(X) :- solver([c, m, p], [a, b, d, e, r, y, a, k, n, b, z], X).
% X = [[b, a, e, d, b, a], [n, k], [z, y, r]]

solution(X) :- test_solver(X).
