my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.

% manhattan_dist(+Point1: [2]number, +Point2: [2]number, -Distance: number)
manhattan_dist([X1, Y1], [X2, Y2], D) :-
    DX is X1 - X2,
    DY is Y1 - Y2,
    my_abs(DX, DXA),
    my_abs(DY, DYA),
    D is DXA + DYA.


% dist(+Point1: [2]number, +Point2: [2]number, -Distance: number)
% this actually gives distance squared
dist([X1, Y1], [X2, Y2], Dist) :- 
	DX is X1 - X2,
    DY is Y1 - Y2,
    Dist is (DX * DX) + (DY * DY).

test_dist(X, Y) :-
    dist([0, 0], [3, 4], X),
    dist([1, 1], [4, 5], Y).
% X = 25
% Y = 25