my_abs(X, X) :- X >= 0, !.
my_abs(X, X2) :- X2 is -X.


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
%type a and type b can be the same
to_key(X, Y) :- my_abs(X, Y).


% min_by_key(+List, -MinByKey)
min_by_key([X], X).
min_by_key([H|T], H) :- 
    min_by_key(T, TMin), 
    to_key(TMin, TKey), 
    to_key(H, HK), 
    TKey > HK, 
    !.
min_by_key([_|T], TMin) :-  
    min_by_key(T, TMin), 
    !.

test_min_by_key(X) :- min_by_key([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17], X).
% X = 0
