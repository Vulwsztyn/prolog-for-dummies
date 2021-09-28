% my_middle(+Interval: [2]number, -Middle: number)
my_middle([A, B], M) :- M is (A+B)/2.

test_my_middle(X, Y) :- my_middle([-3, 5], X), my_middle([-3, 4], Y).
% X = 1,
% Y = 0.5

is_inside_inclusive(N, [S, G]) :- N >= S, N =< G.
is_inside_left_inclusive(N, [S, G]) :- N >= S, N < G.
is_inside_right_inclusive(N, [S, G]) :- N > S, N =< G.
is_inside_exclusive(N, [S, G]) :- N > S, N < G.


dont_overlap_exclusive([_, Y1], [X2, _]) :- Y1 =< X2.
dont_overlap_exclusive([X1, _], [_, Y2]) :- X1 >= Y2.

overlap_exclusive(A, B) :- not(dont_overlap_exclusive(A, B)).

test(overlap_exclusive) :- 
    assertion(overlap_exclusive([2.99, 4], [2, 3])),
    assertion(overlap_exclusive([1, 2.1], [2, 3])),
    assertion(not(overlap_exclusive([3, 4], [2, 3]))),
    assertion(not(overlap_exclusive([1, 2], [2, 3]))),
    assertion(not(overlap_exclusive([-100, -50], [2, 3]))),
    assertion(not(overlap_exclusive([1000, 2000], [2, 3]))).


dont_overlap_inclusive([_, Y1], [X2, _]) :- Y1 < X2.
dont_overlap_inclusive([X1, _], [_, Y2]) :- X1 > Y2.

overlap_inclusive(A, B) :- not(dont_overlap_inclusive(A, B)).

test(overlap_inclusive) :- 
    assertion(overlap_inclusive([2.99, 4], [2, 3])),
    assertion(overlap_inclusive([1, 2.1], [2, 3])),
    assertion(overlap_inclusive([3, 4], [2, 3])),
    assertion(overlap_inclusive([1, 2], [2, 3])),
    assertion(not(overlap_inclusive([-100, -50], [2, 3]))),
    assertion(not(overlap_inclusive([1000, 2000], [2, 3]))).