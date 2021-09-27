% is_inside_right_inclusive(+Elem, +Interval)
% this one is tricky, it doesn't "return" anything it just "is"
is_inside_right_inclusive(N, [S, G]) :- N > S, N =< G.

test_is_inside_right_inclusive_1('3 is in the interval') :- is_inside_right_inclusive(3, [2, 4]).
test_is_inside_right_inclusive_2('3 is not in the interval') :- not(is_inside_right_inclusive(3, [3, 6])).

% is_inside_exclusive(+Elem, +Interval)
% this one is tricky, it doesn't "return" anything it just "is"
is_inside_exclusive(N, [S, G]) :- N > S, N < G.

test_is_inside_exclusive_1('3 is in the interval') :- is_inside_exclusive(3, [2, 4]).
test_is_inside_exclusive_2('6 is not in the interval') :- not(is_inside_exclusive(6, [3, 6])).


% leave_only_included(+Interval: [Int, Int], +Numbers: [Int], -NumbersInInterval: [Int])
leave_only_included(_, [], []).
leave_only_included(N, [H|T], [H|T2]) :- is_inside_exclusive(H, N), leave_only_included(N, T, T2), !.
leave_only_included(N, [_|T], T2) :- leave_only_included(N, T, T2).

test_leave_only_included(X) :- leave_only_included([-3, 5], [-4, -1, 2, 4, 5, 7, 8, 9], X).
% X = [-1, 2, 4]


% merge_interval_with_included(+Interval: [Int, Int], +Included: [Int], -Concatenated: [Int])
merge_interval_with_included([S, E], I, R) :- append([S|I], [E], R).

test_merge_interval_with_included(R) :- merge_interval_with_included([-3, 5], [-1, 2, 4], R).
% R = [-3, -1, 2, 4, 5]


% list_to_intervals(+List: [Int], -Intervals: [[Int, Int]])
list_to_intervals([], []).
list_to_intervals([_], []) :- !.
list_to_intervals([H1, H2|T], [[H1, H2]|TM]) :- list_to_intervals([H2|T], TM).

test_list_to_intervals(X) :- list_to_intervals([-3, -1, 2, 4, 5], X).
% X = [[-3, -1], [-1, 2], [2, 4], [4, 5]]


% my_middle(+Interval: [Int, Int], -Middle: Float)
my_middle([A, B], M) :- M is (A+B)/2.

test_my_middle(X, Y) :- my_middle([-3, 5], X), my_middle([-3, 4], Y).
% X = 1,
% Y = 0.5


% interval_width(+Interval: [Int, Int], -Width: Float)
interval_width([A, B], W) :- W is B - A.

test_interval_width(X, Y) :- interval_width([-3, 5], X), interval_width([-3, 4], Y).
% X = 8,
% Y = 7

% find_including(+ListOfIntervals: [[Int, Int]], +Int: Int, -IntervalIncludingInt: [Int, Int])
find_including([H|_], N, H) :- 
    is_inside_right_inclusive(N, H),
    !.
find_including([_|T], N, X) :- 
    find_including(T, N, X).

test_find_including(X, Y) :- find_including([[-3, -1], [-1, 2], [2, 4], [4, 5]], 1, X),
    find_including([[-3, -1], [-1, 2], [2, 4], [4, 5]], 4, Y).
% X = [-1, 2],
% Y = [2, 4]


% my_abs(+Value, -AbsoluteValue)
my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.

my_abs_test(X, Y) :- my_abs(5, X), my_abs(-3, Y).
% X = 5,
% Y = 3

to_key(I, L, NumsInside, AllNums, Intervals, M, Including, W, W2, D, K) :-
    leave_only_included(I, L, NumsInside),
    merge_interval_with_included(I, NumsInside, AllNums),
    list_to_intervals(AllNums, Intervals),
    my_middle(I, M),
    find_including(Intervals, M, Including),
    interval_width(I, W),
    interval_width(Including, W2),
    D is W - W2,
    my_abs(D, K).

test_to_key(NumsInside, AllNums, Intervals, M, Including, W, W2, D, K) :- 
    to_key([-3, 5], [-4, -1, 2, 4, 5, 7, 8, 9], NumsInside, AllNums, Intervals, M, Including, W, W2, D, K).
% NumsInside = [-1, 2, 4],
% AllNums = [-3, -1, 2, 4, 5],
% Intervals = [[-3, -1], [-1, 2], [2, 4], [4, 5]],
% M = 1,
% Including = [-1, 2],
% W = 8,
% W2 = 3,
% D = 5, 
% K = 5,
test_to_key1(NumsInside, AllNums, Intervals, M, Including, W, W2, D, K) :- 
    to_key([2, 10], [-4, -1, 2, 4, 5, 7, 8, 9], NumsInside, AllNums, Intervals, M, Including, W, W2, D, K).
% NumsInside = [4, 5, 7, 8, 9],
% AllNums = [2, 4, 5, 7, 8, 9, 10],
% Intervals = [[2, 4], [4, 5], [5, 7], [7, 8], [8, 9], [9, 10]],
% M = 6,
% Including = [5, 7],
% W = 8,
% W2 = 2,
% D = K,
% K = M
    

% max_by_key(+List, -MaxByKey)
max_by_key([X], _, X).
max_by_key([H|T], L, H) :- 
    max_by_key(T, L, TMax), 
    to_key(TMax, L, _, _, _, _, _, _, _, _, TKey), 
    to_key(H, L, _, _, _, _, _, _, _, _, HK), 
    TKey < HK, 
    !.
max_by_key([_|T], L, TMax) :-  
    max_by_key(T, L, TMax), 
    !.

test_max_by_key(X) :- max_by_key([[-3, 5], [0, 7], [2, 10], [3, 8], [-2, 2]], [-4, -1, 2, 4, 5, 7, 8, 9], X).
% X = [2, 10]

solve(X, Y, Z) :- max_by_key(X, Y, Z).

solution(X) :- solve([[-3, 5], [0, 7], [2, 10], [3, 8], [-2, 2]], [-4, -1, 2, 4, 5, 7, 8, 9], X).
% X = [2, 10]