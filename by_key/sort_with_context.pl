% my_abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
my_abs(X,X) :- X >= 0, !.
my_abs(X,X2) :- X2 is -X.

% version for people who do not remember that ! stops evaluation
% my_abs(X,X) :- X >= 0, !.
% my_abs(X,X2) :- X < 0, X2 is -X.

my_abs_test(X,Y) :- my_abs(5,X), my_abs(-3,Y).
% X = 5,
% Y = 3


% distance(+Elem1, +Elem2, -Dist)
distance(X,Y,Z) :- Z1 is X - Y, my_abs(Z1,Z).

test_distance(X) :- distance(1,3,X).
% X = 2


% find_min_diff(+Elem, +List, -MinDiffToInputElem)
find_min_diff(X,[H],DH) :- distance(X,H,DH), !.
find_min_diff(X,[H|T],DH) :-
    find_min_diff(X,T,DT),
    distance(X,H,DH),
    DH < DT,
    !
    .
find_min_diff(X,[_|T],DT) :-
    find_min_diff(X,T,DT).

test_find_min_diff(X) :- find_min_diff(2,[0,3,4],X).
% X = 1


% to_key needs to follow the signature
% to_key(+Elem: a, +List: [a], -KeyFromElem: b) 
%type a and type b can be the same
to_key(X,L,Y) :- find_min_diff(X,L,Y).


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

test_pivoting(L,G) :- pivoting(10,[ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17], [ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],L,G).
% G = [-18, 15, -13, 14, 12, -19, -16, 11, -17],
% L = [3, 6, -5, 2, -8, 0, -7, 9, -10, -1, 4]


% perform_quick_sort(+List: [a], -SortedList: [a])
perform_quick_sort([],_,[]) :- !.
perform_quick_sort([H|T],List,Sorted):-
    pivoting(H,List,T,L,G), 
    perform_quick_sort(L,List,SortedL), 
    perform_quick_sort(G,List,SortedG),
    append(SortedL,[H|SortedG],Sorted),
    !.

test_perform_quick_sort(X) :- perform_quick_sort([ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],[ 3, -18, 6, -5, 2, -8, 15, -13, 14, -0, 12, -7, 9, -10, -19, -16, 11, -1, 4, -17],X).
% X = [0, -1, 2, 3, 4, -5, 6, -7, -8, 9, -10, 11, 12, -13, 14, 15, -16, -17, -18, -19]

quick_sort(A,B):- perform_quick_sort(A,A,B).