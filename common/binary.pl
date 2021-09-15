% to_binary(+Int, -ListOfBits)
to_binary(X, [X]) :- X < 2, !.
to_binary(N, Result) :- 
    NMod10 is N mod 2, 
    NBy10 is N // 2,
    to_binary(NBy10, PartialResult),
    append(PartialResult, [NMod10], Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_to_binary(X, Y) :- 
    to_binary(12345, X, Z), 
    to_binary(0, Y),
    .
% X = [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1]
% Y = [0]


% from_binary(+ListOfBits, -Number)
from_binary([], 0).
from_binary(L, N) :-
    append(Init, [Last], L),
	from_binary(Init, N1),
    N is N1 * 2 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_binary(X) :- from_binary([1, 0, 1, 0, 0, 1, 1, 0, 1, 0], X).
% X = 666


% to_any_radix(+Radix, +Int, -ListOfBits)
to_any_radix(R, N, [N]) :- N < R, !.
to_any_radix(R, N, Result) :- 
    NMod10 is N mod R, 
    NBy10 is N // R,
    to_any_radix(R, NBy10, PartialResult),
    append(PartialResult, [NMod10], Result).

test_to_any_radix(X, Y) :- 
    to_any_radix(16, 255, X), 
    to_any_radix(16, 0, Y).
% X = [15, 15]
% Y = [0]

% from_any_radix(+ListOfBits, -Number)
from_any_radix(_, [], 0).
from_any_radix(R, L, N) :-
    append(Init, [Last], L),
	from_any_radix(R, Init, N1),
    N is N1 * R + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_any_radix(X, Y) :- 
    from_any_radix(2, [1, 0, 1, 0, 0, 1, 1, 0, 1, 0], X),
    from_any_radix(16, [15, 15], Y).
% X = 666,
% Y = 255