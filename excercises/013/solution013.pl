% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one_once([],_,[]).
remove_one_once([H|T],H,T) :-!.
remove_one_once([H|T],E,[H|Removed]) :-
    remove_one_once(T,E,Removed).


test_remove_one_once(X) :- remove_one_once([6,2,6,1,6,3,6,7],6,X).
% X = [2, 6, 1, 6, 3, 6, 7]


% my_min(+List, -Min).
my_min([X],X).
my_min([H|T],H) :- my_min(T,MT), MT > H, !.
my_min([_|T],MT) :- my_min(T,MT).

test_my_min(X) :- my_min([16, 18, 22, 27, 12, 25, 21],X).
% X = 12
 

% my_abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
my_abs(X,X) :- X >= 0, !.
my_abs(X,X2) :- X2 is -X.

my_abs_test(X,Y) :- my_abs(5,X), my_abs(-3,Y).
% X = 5,
% Y = 3


% my_middle(+Interval: [Int,Int], -Middle: Float)
my_middle([A,B],M) :- M is (A+B)/2.

test_my_middle(X,Y) :- my_middle([-3,5],X), my_middle([-3,4],Y).
% X = 1,
% Y = 0.5


% map_to_diff(+List, +Value, -ListOfDiffs)
% maps List to list of absolute differences of List elements to Value
map_to_diff([],_,[]).
map_to_diff([H|T],L,[H2|T2]) :-
    Diff is H-L,
    my_abs(Diff,H2),
    map_to_diff(T,L,T2).

test_map_to_diff(X) :- map_to_diff([0, 9, 13, 19, 2, 14, 6], 3, X).
% X = [3, 6, 10, 16, 1, 11, 3]


% map_to_middle(+List,-ListOfMiddles)
map_to_middle([],[]).
map_to_middle([H|T],[H2|T2]) :-
    my_middle(H,H2),
    map_to_middle(T,T2).

test_map_to_middle(X) :- map_to_middle([[-3,4],[-3,5]],X).
% X = [0.5, 1]


% to_key(+Elem,+List,-Key)
to_key(Elem,List,Key) :-
    remove_one_once(List,Elem,ListWithoutElem),
    my_middle(Elem,MidElem),
    map_to_middle(ListWithoutElem,Mids),
    map_to_diff(Mids,MidElem,Diffs),
    my_min(Diffs,Key),
    !.


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

%% COPY END

test_quick_sort(X) :- quick_sort([[-1,3],[14,20],[0,14]],X).
% X = [[0, 14], [-1, 3], [14, 20]]

solution(X) :- test_quick_sort(X).