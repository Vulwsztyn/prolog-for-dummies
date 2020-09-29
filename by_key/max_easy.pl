my_abs(X,X) :- X >= 0, !.
my_abs(X,X2) :- X2 is -X.


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
%type a and type b can be the same
to_key(X,Y) :- my_abs(X,Y).


% max_by_key(+List, -MaxByKey)
max_by_key([X],X).
max_by_key([H|T],H) :- 
    max_by_key(T,TMax), 
    to_key(TMax,TKey), 
    to_key(H,HK), 
    TKey < HK, 
    !.
max_by_key([_|T],TMax) :-  
    max_by_key(T,TMax), 
    !.

test_max_by_key(X) :- max_by_key([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],X).
% X = -19
