% my_count(+Elem: a, +List: [a], -NumberOfOccurences: Int)
my_count(_,[],0).
my_count(H,[H|T],N) :-
    my_count(H,T,N1),
    N is N1 + 1,
    !.
my_count(X,[_|T],N) :-
    my_count(X,T,N).

test_my_count(X) :- my_count(5,[6,7,5,6,7,5,6,7,6,5],X).
% X = 3


% map_to_counts(+ListOfElems: [a], +List: [a], -CountsOfElemsInList: [Int])
map_to_counts([],_,[]).
map_to_counts([H|T],L,[HM|TM]) :- 
    my_count(H,L,HM), 
    map_to_counts(T,L,TM),
    !.

test_map_to_counts(X) :- map_to_counts([4,5,6,7],[6,7,5,6,7,5,6,7,6,5],X).
% X = [0, 3, 4, 3]

% int_to_list_of_digits(+Int: Int, -ListOfDigits: [Int])
int_to_list_of_digits(0,[]) :- !.
int_to_list_of_digits(N,Result) :- 
    NMod10 is N mod 10, 
    NBy10 is N // 10,
    int_to_list_of_digits(NBy10,PartialResult),
    append(PartialResult,[NMod10],Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_int_to_list_of_digits(X) :- int_to_list_of_digits(123,X).
% X = [1, 2, 3]


% map_to_lists_of_digits(+List: [Int], -ListOfListsOfDigits: [[Int]])
map_to_lists_of_digits([],[]).
map_to_lists_of_digits([H|T],[HM|TM]) :-
    map_to_lists_of_digits(T,TM),
    int_to_list_of_digits(H,HM),
    !.
 
test_map_to_lists_of_digits(X) :- map_to_lists_of_digits([1,567,98,0],X).
% X = [[1], [5, 6, 7], [9, 8], []]


% remove_one(+List: [a], +Elem: a, -ListWithoutElem: [a])
remove_one([],_,[]).
remove_one([H|T],H,Filtered) :-
    remove_one(T,H,Filtered),
    !.
remove_one([H|T],E,[H|Filtered]) :-
    H =\= E,
    remove_one(T,E,Filtered).

test_remove_one(X) :- remove_one([6,2,6,1,6,3,6,7],6,X).
% X = [2, 1, 3, 7]


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
 

% my_average(+List, -Average)
% returns average of list
% ! is not needed as it is not reccursive
my_average(L,A) :- my_sum(L,S), length(L,Len), A is S / Len.

test_my_average(A,B,C,D,E) :- my_average([16, 18, 22, 27, 12, 25, 21],A),
    my_average([16, 18, 22, 27],B),
    my_average([18, 22, 27, 12],C),
    my_average([22, 27, 12, 25],D),
    my_average([27, 12, 25, 21],E).
% A = 20.142857142857142,
% B = 20.75,
% C = 19.75,
% D = 21.5,
% E = 21.25


% flatten(+ListOfLists: [[a]], -FlatList: [a])
my_flatten([],[]).
my_flatten([H|T],R) :-
    flatten(T,R1),
    append(H,R1,R).

test_my_flatten(X) :- my_flatten([[1], [5, 6, 7], [9, 8], []],X).
% X = [1, 5, 6, 7, 9, 8]

% to_key(+Ele: Int, +WholeList: [Int], -Key: Float)
to_key(E,L,K) :-
    remove_one(L,E,LF),
    int_to_list_of_digits(E,ED),
    map_to_lists_of_digits(LF,LLD),
    my_flatten(LLD,LD),
    map_to_counts(ED,LD,LC),
    my_average(LC,K).


test_to_key(X) :- to_key(271,[271,5123,167,14,628,3120],X).
% K = 2.6666666666666665


% min_by_key(+List, -MinByKey)
min_by_key([X],_,X).
min_by_key([H|T],L,H) :- 
    min_by_key(T,L,TMin), 
    to_key(TMin,L,TKey), 
    to_key(H,L,HK), 
    TKey > HK, 
    !.
min_by_key([_|T],L,TMin) :-  
    min_by_key(T,L,TMin), 
    !.

test_min_by_key(X) :- min_by_key([271,5123,167,14,628,3120],[271,5123,167,14,628,3120],X).
% X = 628








