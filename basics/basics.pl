% my_head(+List, -Head)
% predicate used to extract head from list
% no ! is needed as it is not a recursive predicate
my_head([H|_],H).


test_my_head(X) :- my_head([1,2,3],X).
% X = 1


% my_tail(+List, -Tail)
% predicate used to extract tail from list
% no ! is needed as it is not a recursive predicate
my_tail([_|T],T).

test_my_tail(X) :- my_tail([1,2,3],X).
% X = [2,3]


% my_head_and_tail(+List, -Head, -Tail)
% predicate used to extract tail from list
% no ! is needed as it is not a recursive predicate
my_head_and_tail([H|T],H,T).

test_my_head_and_tail(H,T) :- my_head_and_tail([a,1,'dupa'],H,T).
% H = a
% T = [1, 'dupa']


% my_length(+List, -Length)
% predicate used to extract head from list
% no ! is needed as there is only one way the predicate can be interpreted (or something like that I don't fully get it either)
% the `stop` (non-recursive) version of this predicate looks like that, because `[]` is the shortest list possible
% N in the recursive version of this predicate is the length of tail of the list which we know is shorter by one element than the current list
my_length([],0).
my_length([_|T],N1) :- my_length(T,N), N1 is N + 1.

test_my_length(L) :- my_length(['Z','i','b','r','o',',',' ','T','y',' ','k'],L).
% L = 11

% the other option for the `stop` predicate is 
% my_length([_],1).
% but as you know a list can be empty and it wouldn't work for `[]` then

% the wrong way to write the recursive version of this predicate is
% my_length([_|T],N1) :- N1 is N + 1, my_length(T,N).
% N's wouldn't be known to the compiler then and it would go forever searching for it
% look at the Python version 

% my_member(+Elem, +List)
% predicate used to check whether the element is in the list
% ! is needed because my_member(1,[1]) would return true form first line and then go on to the next to check
% you are welcome to remove the ! and check yourself
my_member(H,[H|_]) :- !.
my_member(X,[_|T]) :- my_member(X,T).

test_my_member('2 is in the list') :- my_member(2,[1,2,2,3]).
test_my_member2('2 is not in the list') :- not(my_member(2,[1,3])).

% this function can be a one liner, but it uses `;` which can be treated as else, but is disallowed
my_member_one_liner(X, [Y|T]) :- X = Y; my_member_one_liner(X, T).

% my_last(+List, -LastElement)
% returns last element of the list
% ! is needed as both a list of length one fits both [X] and [_|T] 
my_last([X],X) :- !.
my_last([_|T],X) :- my_last(T,X).

test_my_last(L) :- my_last(['Kyoshi','Roku','Aang'],L).
% L = 'Aang'

% please notice that the ! wouldn't be needed if I wrote it like this
my_last2([X],X).
my_last2([_,H|T],X) :- my_last([H|T],X).
% it is because a [_,H|T] means a list of at least 2 elements
% it is less elegant tho

test_my_last2(L) :- my_last2(['Kaladin','','Aang'],L).
% L = 'Aang'

% my_init(+List, -Init)
% returns all but last elements of the list
% ! is needed as both a list of length one fits both [X] and [H|T] 
my_init([_],[]) :- !.
my_init([H|T],[H|InitT]) :- my_init(T,InitT).


test_my_init(X) :- my_init([1,2,3,4,5,6,7],X).
% X = [1, 2, 3, 4, 5, 6]

%Once again it could be written without ! if +List in the second line wouldn't match a one element list
my_init2([_],[]).
my_init2([H,H1|T],[H|InitT]) :- my_init([H1|T],InitT).


test_my_init2(X) :- my_init2([1,2,3,4,5,6,7],X).
% X = [1, 2, 3, 4, 5, 6]

% my_init_and_last(+List, -Init, -Last)
% init and last combined
% ! is needed as both a list of length one fits both [X] and [H|T] 
my_init_and_last([X],[],X) :- !.
my_init_and_last([H|T],[H|Init],Last) :- my_init_and_last(T,Init,Last).

test_my_init_and_last(I,L) :- my_init_and_last([1,2,3],I,L).
% I = [1, 2],
% L = 3
 

% my_prepend(+NewElem, +List, -PrependedList)
% prepends a list
% no ! is needed as it is not a recursive predicate
my_prepend(H,T,[H|T]).

test_my_prepend(X) :- my_prepend(a,[b,c],X).
% X = [a, b, c] 


% my_concat(+List1,+List2,-ConcatenatedList)
% concatenated 2 lists into the result (works just as append when 2 first parameters are supplied i.e. append([1],[2,3],X).)
my_concat([],X,X) :- !.
my_concat(L1,L2,R) :- my_init_and_last(L1,Init,Last), my_concat(Init,[Last|L2],R).

test_my_concat(X) :- my_concat([1,2,3],[4,5,6],X).
% X = [1, 2, 3, 4, 5, 6]
