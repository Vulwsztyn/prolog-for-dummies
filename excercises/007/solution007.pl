% my_repeat(+Elem: a, +Count: Int, -List: [a])
my_repeat(_,0,[]) :- !.
my_repeat(E,N,[E|T]) :-
    N1 is N - 1,
    my_repeat(E,N1,T).

test_my_repeat(X) :- my_repeat(1,10,X).
% X = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]


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


% to_binary(+Int: Int, -ListOfBits: [Int])
to_binary(0,[]) :- !.
to_binary(N,Result) :- 
    NMod10 is N mod 2, 
    NBy10 is N // 2,
    to_binary(NBy10,PartialResult),
    append(PartialResult,[NMod10],Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_to_binary(X) :- to_binary(12345,X).
% X = [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1]


% from_binary(+ListOfBits, -Number)
from_binary([],0).
from_binary(L,N) :-
    append(Init,[Last],L),
	from_binary(Init,N1),
    N is N1 * 2 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_from_binary(X) :- from_binary([1,0,1,0,0,1,1,0,1,0],X).
% X = 666
 

% append_1_or_0_until_equal_number(+NumberInBinary: [Int], -NumberWithEqualNumberOf0sAnd1s: [Int])
append_1_or_0_until_equal_number(N,R) :-
    my_count(1,N,C1),
    my_count(0,N,C0),
    C1 >= C0,
    Diff is C1 - C0,
    my_repeat(0,Diff,Zeros),
    append(N,Zeros,R),
    !.
append_1_or_0_until_equal_number(N,R) :-
    my_count(1,N,C1),
    my_count(0,N,C0),
    C1 < C0,
    Diff is C0 - C1,
    my_repeat(1,Diff,Ones),
    append(N,Ones,R).
    
test_append_1_or_0_until_equal_number(X,Y) :- 
    append_1_or_0_until_equal_number([1,1,1,0],X),
    append_1_or_0_until_equal_number([1,1,1,0,0,0,0,0,0,0],Y).
% X = [1, 1, 1, 0, 0, 0],
% Y = [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
      

% move_ones_to_left(+NumberInBinary: [Int], -NumberWithOnesOnTheLeft: [Int])
move_ones_to_left(N,N1) :-
    my_count(1,N,C1),
    my_count(0,N,C0),
    my_repeat(1,C1,Ones),
    my_repeat(0,C0,Ziobros),
    append(Ones,Ziobros,N1).
  
test_move_ones_to_left(X) :- move_ones_to_left([1,0,1,0,1],X).
% X = [1, 1, 1, 0, 0]


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


% to_key needs to follow the signature
% to_key(+Elem: a, -KeyFromElem: b) 
% type a and type b can be the same
to_key(X,K) :- 
    to_binary(X,XB),
    move_ones_to_left(XB,XBSorted),
    append_1_or_0_until_equal_number(XBSorted,XBBalanced),
    from_binary(XBBalanced, NewNum),
    Diff is X - NewNum,
    my_abs(Diff,K).
    

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

test_max_by_key(X) :- max_by_key([21,23,29,33],X).
% X = 23

solve(X,Y) :- max_by_key(X,Y).
