% everything before pivoting is only here to show example usage
my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
%type a and type b can be the same
to_key(X, Y) :- my_abs(X, Y).


% map_to_pairs (+List: [a], -ListWithKeys: [[a, b]])
% assuming to_key(+Elem: a, -KeyFromElem: b)
map_to_pairs([], []).
map_to_pairs([H|T], [[H, HM]|TM]) :-
    map_to_pairs(T, TM),
    to_key(H, HM).

test_map_to_pairs(X) :- map_to_pairs([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17], X).
% X = [[3, 3], [-18, 18], [6, 6], [-5, 5], [2, 2], [-8, 8], [15, 15], [-13, 13], [14, 14], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [-19, 19], [-16, 16], [11, 11], [-1, 1], [4, 4], [-17, 17]]


% extract_key needs to follow the signature
% extract_key(+Elem: [a, b], -KeyFromElem: b) 
%type a and type b can be the same
extract_key([_, K], K).


% extract_elem_from_list(+ListOfPairs: [[a, b]], -List: [a])
extract_elem_from_list([], []).
extract_elem_from_list([[H, _]|T], [H|TE]) :-
    extract_elem_from_list(T, TE).

extract_elem_from_list(X) :- extract_elem_from_list([[0, 0], [-1, 1], [2, 2], [3, 3], [4, 4], [-5, 5], [6, 6], [-7, 7], [-8, 8], [9, 9], [-10, 10], [11, 11], [12, 12], [-13, 13], [14, 14], [15, 15], [-16, 16], [-17, 17], [-18, 18], [-19, 19]], X).
% X = [0, -1, 2, 3, 4, -5, 6, -7, -8, 9, -10, 11, 12, -13, 14, 15, -16, -17, -18, -19]


% pivoting(+Pivot: [a, b], +List: [[a, b]], -Lesser: [[a, b]], -Greater: [[a, b]])
pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :-
    pivoting(P, T, L, G), 
    extract_key(H, HKey),
    extract_key(P, PKey),
    HKey =< PKey,
    !.
pivoting(P, [H|T], L, [H|G]) :- 
    pivoting(P, T, L, G).

test_pivoting(L, G) :- pivoting([-13, 13], [[3, 3], [-18, 18], [6, 6], [-5, 5], [2, 2], [-8, 8], [15, 15], [-13, 13], [14, 14], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [-19, 19], [-16, 16], [11, 11], [-1, 1], [4, 4], [-17, 17]], L, G).
% G = [[-18, 18], [15, 15], [14, 14], [-19, 19], [-16, 16], [-17, 17]],
% L = [[3, 3], [6, 6], [-5, 5], [2, 2], [-8, 8], [-13, 13], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [11, 11], [-1, 1], [4, 4]]


% quick_sort(+List: [[a, b]], -SortedList: [[a, b]])
quick_sort([], []) :- !.
quick_sort([H|T], Sorted):-
    pivoting(H, T, L, G), 
    quick_sort(L, SortedL), 
    quick_sort(G, SortedG),
    append(SortedL, [H|SortedG], Sorted),
    !.

test_quick_sort(X) :- quick_sort([[3, 3], [-18, 18], [6, 6], [-5, 5], [2, 2], [-8, 8], [15, 15], [-13, 13], [14, 14], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [-19, 19], [-16, 16], [11, 11], [-1, 1], [4, 4], [-17, 17]], X).
% X = [[0, 0], [-1, 1], [2, 2], [3, 3], [4, 4], [-5, 5], [6, 6], [-7, 7], [-8, 8], [9, 9], [-10, 10], [11, 11], [12, 12], [-13, 13], [14, 14], [15, 15], [-16, 16], [-17, 17], [-18, 18], [-19, 19]]


% use_quick_sort(+List: [a], -SortedList: [a])
use_quick_sort(L, S) :- 
	map_to_pairs(L, P),
    quick_sort(P, SP),
    extract_elem_from_list(SP, S).

test_use_quick_sort(X) :- use_quick_sort([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17], X).
% X = [0, -1, 2, 3, 4, -5, 6, -7, -8, 9, -10, 11, 12, -13, 14, 15, -16, -17, -18, -19]
