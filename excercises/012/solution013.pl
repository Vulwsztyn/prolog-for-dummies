alphabet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).


% idx(+Elem, +List, -IndexOfElemInList)
idx(H,[H|_],0) :- !.
idx(H,[_|T],N) :-
    idx(H,T,N1),
    N is N1 + 1.

test_idx(X) :- idx(c,[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],X).
% X = 2


% my_abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
my_abs(X,X) :- X >= 0, !.
my_abs(X,X2) :- X2 is -X.

my_abs_test(X,Y) :- my_abs(5,X), my_abs(-3,Y).
% X = 5,
% Y = 3


% my_min(+List, -Min).
my_min([X],X).
my_min([H|T],H) :- my_min(T,MT), MT > H, !.
my_min([_|T],MT) :- my_min(T,MT).

test_my_min(X) :- my_min([16, 18, 22, 27, 12, 25, 21],X).
% X = 12

% map_to_indices(+ListOfElems, +ReferenceList, -ListOfIndices)
% ListOfElems is list of elements to be mapped to indices
% ReferenceList is list contatining the elements at proper indexes
map_to_indices([],_,[]).
map_to_indices([H|T],L,[H2|T2]) :-
    idx(H,L,H2),
    map_to_indices(T,L,T2).


test_map_to_indices(X) :- alphabet(A), map_to_indices([a,j,n,t,c,o,g],A,X). 
% X = [0, 9, 13, 19, 2, 14, 6]


% map_to_diff(+List, +Value, -ListOfDiffs)
% maps List to list of absolute differences of List elements to Value
map_to_diff([],_,[]).
map_to_diff([H|T],L,[H2|T2]) :-
    Diff is H-L,
    my_abs(Diff,H2),
    map_to_diff(T,L,T2).

test_map_to_diff(X) :- map_to_diff([0, 9, 13, 19, 2, 14, 6], 3, X).
% X = [3, 6, 10, 16, 1, 11, 3]


% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one_once([],_,[]).
remove_one_once([H|T],H,T) :-!.
remove_one_once([H|T],E,[H|Removed]) :-
    remove_one_once(T,E,Removed).


test_remove_one_once(X) :- remove_one_once([6,2,6,1,6,3,6,7],6,X).
% X = [2, 6, 1, 6, 3, 6, 7]


% to_key(+Elem, +List, -MinDist)
% MinDist is min index distance between Elem and Elems of List
% where "index distance" means difference between indexes of 2 elems in alphabet
to_key(Elem,List,MinDist) :-
    alphabet(A),
    remove_one_once(List,Elem,ListWithoutElem),
    map_to_indices([Elem|ListWithoutElem],A,[ElemIndex|Indices]),
    map_to_diff(Indices,ElemIndex,Diffs),
    my_min(Diffs,MinDist).

test_to_key(X) :- to_key(a,[a,j,n,t,c,o,g],X).
% X = 2    


%% COPY FROM sort_with_context %%

% pivoting(+Pivot: a, +List: [a], -Lesser: [a], -Greater: [a])
pivoting(_,_,[],[],[]) :- !.
pivoting(P,List,[H|T],[H|L],G) :-
    pivoting(P,List,T,L,G), 
    to_key(H,List,HKey),
    to_key(P,List,PKey),
    HKey =< PKey,
    !.
pivoting(P,List,[H|T],L,[H|G]) :- 
    pivoting(P,List,T,L,G).


% quick_sort(+List: [a], -SortedList: [a])
quick_sort([],[]) :- !.
quick_sort([H|T],Sorted):-
    pivoting(H,T,T,L,G), 
    quick_sort(L,SortedL), 
    quick_sort(G,SortedG),
    append(SortedL,[H|SortedG],Sorted),
    !.

%% COPY END

test_quick_sort(X) :- quick_sort([a,j,n,t,c,o,g],X).

solution(X) :- test_quick_sort(X).
