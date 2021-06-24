% my_length(+List, -Length)
% predicate used to extract head from list
% no ! is needed as there is only one way the predicate can be interpreted (or something like that I don't fully get it either)
% the `stop` (non-recursive) version of this predicate looks like that, because `[]` is the shortest list possible
% N in the recursive version of this predicate is the length of tail of the list which we know is shorter by one element than the current list
my_length([],0).
my_length([_|T],N1) :- my_length(T,N), N1 is N + 1.

test_my_length(L) :- my_length(['Z','i','b','r','o',',',' ','T','y',' ','k'],L).
% L = 11


% my_min(+List, -Min).
my_min([X],X) :- !.
my_min([H|T],H) :- my_min(T,MT), MT > H, !.
my_min([_|T],MT) :- my_min(T,MT).

test_my_min(X) :- my_min([16, 18, 22, 27, 12, 25, 21],X).
% X = 12


% my_max(+List, -Max).
my_max([X],X) :- !.
my_max([H|T],H) :- my_max(T,MT), MT < H, !.
my_max([_|T],MT) :- my_max(T,MT).

test_my_max(X) :- my_max([16, 18, 22, 27, 12, 25, 21],X).
% X = 27

% my_sum(+List, -Sum)
% returns sum of list
% ! is not needed as [] doesn't match [H|T]
my_sum([],0).
my_sum([H|T],N) :- my_sum(T,N1), N is N1 + H.

% it could be written wrong:
% my_sum([H|T],N) :- N is N1 + H, my_sum(T,N1).
% in N is N1 + H both N and N1 would be undefined (order of predicates in the body matters).

test_my_sum(X) :- my_sum([12,25,5],X).
% X = 42

to_key(V,K) :-
    my_min(V, Min),
    my_max(V, Max),
    my_sum(V,Sum),
	my_length(V,L),
    L2 is L - 2,
    Sum2 is Sum - Min - Max,
    K is Sum2 / L2.

test_to_key(X) :- 
    to_key([1,2,3],X).
    %to_key([10,5,15,20,25],Y).


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

test_quick_sort(X) :- quick_sort([21, 15, 11],X).

solution(X) :- test_quick_sort(X).