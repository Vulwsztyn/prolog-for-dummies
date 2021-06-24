% to_any_radix(+Radix, +Int, -ListOfBits)
to_any_radix(_,0,[]) :- !.
to_any_radix(R, N, Result) :- 
    NMod10 is N mod R, 
    NBy10 is N // R,
    to_any_radix(R, NBy10, PartialResult),
    append(PartialResult,[NMod10],Result).

test_to_any_radix(X) :- to_any_radix(16,255,X).
% X = [15, 15]


% from_any_radix(+ListOfBits, -Number)
from_any_radix(_,[],0).
from_any_radix(R,L,N) :-
    append(Init,[Last],L),
	from_any_radix(R,Init,N1),
    N is N1 * R + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_any_radix(X,Y) :- 
    from_any_radix(2,[1,0,1,0,0,1,1,0,1,0],X),
    from_any_radix(16,[15,15],Y).
% X = 666,
% Y = 255


% remove_gte(+ValueToCheckAgainst: Int, +List: []Int, -Filtered: []Int)
remove_gte(_,[],[]).
remove_gte(V,[H|T],[H|T2]) :-
    V > H,
    remove_gte(V,T,T2),
    !.
remove_gte(V,[_|T],T2) :-
    remove_gte(V,T,T2).

test_remove_gte(X) :- remove_gte(10,[11,2,12,3],X).
% X = [2, 3]


to_key(V,K) :-
    to_any_radix(16,V,H),
    remove_gte(10,H,F),
    from_any_radix(10,F,K).

test_to_key(X) :- to_key(164, X).
% X = 4


% pivoting(+Pivot: a, +List: [a], -Lesser: [a], -Greater: [a])
pivoting(_,[],[],[]) :- !.
pivoting(P,[H|T],[H|L],G) :-
    pivoting(P,T,L,G), 
    to_key(H,HKey),
    to_key(P,PKey),
    HKey =< PKey,
    !.
pivoting(P,[H|T],L,[H|G]) :- 
    pivoting(P,T,L,G).


% quick_sort(+List: [a], -SortedList: [a])
quick_sort([],[]) :- !.
quick_sort([H|T],Sorted):-
    pivoting(H,T,L,G), 
    quick_sort(L,SortedL), 
    quick_sort(G,SortedG),
    append(SortedL,[H|SortedG],Sorted),
    !.

test_quick_sort(X) :- quick_sort([164,177,178],X).
% X = [177, 178, 164]

solution(X) :- test_quick_sort(X).
