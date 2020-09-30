max_by_key([X],_,X).
max_by_key([H|T],L,H) :- 
    max_by_key(T,L,TMax), 
    to_key(TMax,L,TKey), 
    to_key(H,L,HK), 
    TKey < HK, 
    !.
max_by_key([_|T],L,TMax) :-  
    max_by_key(T,L,TMax), 
    !.