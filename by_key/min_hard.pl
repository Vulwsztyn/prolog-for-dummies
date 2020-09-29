% everything before pivoting is only here to show example usage
my_abs(X,X) :- X >= 0, !.
my_abs(X,X2) :- X2 is -X.


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
%type a and type b can be the same
to_key(X,Y) :- my_abs(X,Y).


% map_to_pairs (+List: [a], -ListWithKeys: [[a,b]])
% assuming to_key(+Elem: a, -KeyFromElem: b)
map_to_pairs([],[]).
map_to_pairs([H|T],[[H,HM]|TM]) :-
    map_to_pairs(T,TM),
    to_key(H,HM).

test_map_to_pairs(X) :- map_to_pairs([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],X).
% X = [[3, 3], [-18, 18], [6, 6], [-5, 5], [2, 2], [-8, 8], [15, 15], [-13, 13], [14, 14], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [-19, 19], [-16, 16], [11, 11], [-1, 1], [4, 4], [-17, 17]]


% extract_key needs to follow the signature
% extract_key(+Elem: [a,b], -KeyFromElem: b) 
%type a and type b can be the same
extract_key([_,K],K).


% extract_elem_from_pair(+Pair: [a,b], -List: [a])
extract_elem_from_pair([H,_],H).

extract_elem_from_list(X) :- extract_elem_from_list([[0, 0], [-1, 1], [2, 2], [3, 3], [4, 4], [-5, 5], [6, 6], [-7, 7], [-8, 8], [9, 9], [-10, 10], [11, 11], [12, 12], [-13, 13], [14, 14], [15, 15], [-16, 16], [-17, 17], [-18, 18], [-19, 19]],X).
% X = [0, -1, 2, 3, 4, -5, 6, -7, -8, 9, -10, 11, 12, -13, 14, 15, -16, -17, -18, -19]

% min_by_key(+List: [[a,b]], -MinByKey: [a,b])
min_by_key([X],X).
min_by_key([H|T],H) :- 
    min_by_key(T,TMin), 
    extract_key(TMin,TKey), 
    extract_key(H,HK), 
    TKey > HK, 
    !.
min_by_key([_|T],TMin) :-  
    min_by_key(T,TMin), 
    !.

test_min_by_key(X) :- min_by_key([[3, 3], [-18, 18], [6, 6], [-5, 5], [2, 2], [-8, 8], [15, 15], [-13, 13], [14, 14], [0, 0], [12, 12], [-7, 7], [9, 9], [-10, 10], [-19, 19], [-16, 16], [11, 11], [-1, 1], [4, 4], [-17, 17]],X).
% X = [0, 0]


% use_min_by_key(+List: [a], -SortedList: [a])
use_min_by_key(L,S) :- 
	map_to_pairs(L,P),
    min_by_key(P,SP),
    extract_elem_from_pair(SP,S).

test_use_min_by_key(X) :- use_min_by_key([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],X).
% X = 0
