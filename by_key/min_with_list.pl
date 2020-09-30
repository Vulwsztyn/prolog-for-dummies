min_by_key([X],_,X).
min_by_key([H|T],L,H) :- 
    min_by_key(T,L,TMax), 
    to_key(TMax,L,TKey), 
    to_key(H,L,HK), 
    TKey > HK, 
    !.
min_by_key([_|T],L,TMax) :-  
    min_by_key(T,L,TMax), 
    !.