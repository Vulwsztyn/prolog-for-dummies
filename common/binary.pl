% to_binary(+Int, -ListOfBits)
to_binary(0,[]) :- !.
to_binary(N,Result) :- 
    NMod10 is N mod 2, 
    NBy10 is N // 2,
    to_binary(NBy10,PartialResult),
    append(PartialResult,[NMod10],Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_to_binary(X) :- to_binary(12345,X).
% X = [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1]


% from_binary(+ListOfBits, -Number)
from_binary([],0).
from_binary(L,N) :-
    append(Init,[Last],L),
	from_binary(Init,N1),
    N is N1 * 2 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_binary(X) :- from_binary([1,0,1,0,0,1,1,0,1,0],X).
% X = 666