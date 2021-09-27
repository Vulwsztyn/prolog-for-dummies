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


% leave_only_included(+Interval: [2]number, +List: []number, -ListOfIncluded: []number)
leave_only_included(_, [], []).
leave_only_included(N, [H|T], [H|T2]) :- is_inside_inclusively(H, N), leave_only_included(N, T, T2), !.
leave_only_included(N, [_|T], T2) :- leave_only_included(N, T, T2).

test_leave_only_included(X) :- leave_only_included([0, 7], [-4, -1, 2, 4, 5, 7, 8, 9], X).
% X = [2, 4, 5, 7]


% find_furthest(+From: number, +List: []number, -Furthest: number)
find_furthest(_, [X], X) :- !.
find_furthest(X, [H|T], H) :-
    find_furthest(X, T, FT),
    DT is X - FT,
    DH is X - H,
    my_abs(DT, ADT),
    my_abs(DH, ADH),
    ADH > ADT,
    !.

find_furthest(X, [_|T], FT) :-
    find_furthest(X, T, FT).

test_find_furthest(X) :- find_furthest(6, [2, 4, 5, 7, 8, 9], X).
% X = 2


to_key(I, L, Included, Middle, K) :-
    leave_only_included(I, L, Included),
    my_middle(I, Middle),
    find_furthest(Middle, Included, K).

test_to_key(A1, A2, AKey, B1, B2, BKey, C1, C2, CKey, D1, D2, DKey, E1, E2, EKey) :-
    to_key([-3, 5], [-4, 1, -2, 4, 5, 7, 9], A1, A2, AKey),
    to_key([0, 7], [-4, 1, -2, 4, 5, 7, 9], B1, B2, BKey),
    to_key([2, 10], [-4, 1, -2, 4, 5, 7, 9], C1, C2, CKey),
    to_key([3, 8], [-4, 1, -2, 4, 5, 7, 9], D1, D2, DKey),
    to_key([-2, 2], [-4, 1, -2, 4, 5, 7, 9], E1, E2, EKey).
% A1 = [1, -2, 4, 5],
% A2 = 1,
% AKey = 5,
% B1 = [1, 4, 5, 7],
% B2 = 3.5,
% BKey = 7, 
% C1 = [4, 5, 7, 9],
% C2 = 6,
% CKey = 9,
% D1 = [4, 5, 7],
% D2 = 5.5,
% DKey = 7,
% E1 = [1, -2],
% E2 = 0,
% EKey = -2

max_by_key([X], _, X) :- !.
max_by_key([H|T], L, H) :- 
    max_by_key(T, L, TMax), 
    to_key(TMax, L, _, _, TKey),
    to_key(H, L, _, _, HK),
    TKey =< HK, 
    !.
max_by_key([_|T], L, TMax) :-  
    max_by_key(T, L, TMax).

solution(X) :- max_by_key([[-3, 5], [0, 7], [2, 10], [3, 8], [-2, 2]], [-4, 1, -2, 4, 5, 7, 9], X).