% make_sublists(+List, +Num, -Sublists)
% returns the  list of all sublist of length N composed of consecutive elements of list
% ! not needed in 1st line as [] doesn't match [NewSublist|TSublists]
% ! needed in second line - idk why for now
make_sublists(L,N,[]) :- length(L,Len), Len < N.
make_sublists([H|T],N,[NewSublist|TSublists]) :- make_sublists(T,N,TSublists),append(NewSublist,_,[H|T]),length(NewSublist,N), !.

test_make_sublists(X) :- make_sublists([16, 18, 22, 27, 12, 25, 21],4,X).
% X = [[16, 18, 22, 27], [18, 22, 27, 12], [22, 27, 12, 25], [27, 12, 25, 21]]


% complement(+List, +Sublist, -Complement)
% returns the list of all elements that are not in the sublist
% notice that it will not work if the leements in the list are not unique
% 	or the order of the elements of the Sublist is different in sublist and in list
complement(Orig,[],Orig).
complement([H|TOrig],[H|TSublist],Complement) :- complement(TOrig,TSublist,Complement), !.
complement([H|TOrig],Sublist,[H|Complement]) :- complement(TOrig,Sublist,Complement).

test_complement(X) :- complement([16, 18, 22, 27, 12, 25, 21],[18, 22, 27,12],X).
% X = [16, 25, 21]

% now, I made it that way, because I know what I am doing
% a version that could have been written by someone less accustomed (I do it in overly noob way):
complement2(Orig,[],Orig).
complement2([HO|TOrig],[HS|TSublist],Complement) :- HO =:= HS, complement2(TOrig,TSublist,Complement), !.
complement2([HO|TOrig],[HS|TSublist],[HO|Complement]) :- HO =\= HS, complement2(TOrig,[HS|TSublist],Complement), !.

test_complement2(X) :- complement2([16, 18, 22, 27, 12, 25, 21],[16, 18, 22, 27],X).
% X = [12, 25, 21]


% my_sum(+List, -Sum)
% returns sum of list
% ! is not needed as [] doesn't match [H|T]
my_sum([],0).
my_sum([H|T],N) :- my_sum(T,N1), N is N1 + H.

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


% abs(+Value, -AbsoluteValue)
% you can guess
% ! because X matches X and allows you to not write X < 0
abs(X,X) :- X >= 0, !.
abs(X,X2) :- X2 is -X.

% version for people who do not remember that ! stops evaluation
% abs(X,X) :- X >= 0, !.
% abs(X,X2) :- X <0, X2 is -X.

abs_test(X,Y) :- abs(5,X), abs(-3,Y).


% min_by_key(+List, -MinByKey)
% assuming the list elements are arrays of length 2 containing [Value,Key] it returns the element for the minimal key
% could be called min_by_second_element
my_min_by_key([X],X).
my_min_by_key([[V,K]|T],[V,K]) :- my_min_by_key(T,[_,TKey]), TKey > K, !.
my_min_by_key([_|T],Min) :-  my_min_by_key(T,Min).

% I needed to add my because min_by_key exists in Prolog, debugging this was not rewarding

% and I wrote my_min_by_key([X],X). as my_min_by_key([X],[X]). which would result in type error in any strongly typed language

test_my_min_by_key(X) :- my_min_by_key([[a,3],[b,7],[c,2],[d,6]],X).
% X = [c, 2]


% map_sublist(+Sublist, +List, -Key)
% calculates the differance between averages of the list and the complement of sublist
map_sublist_helper(Sublist,List,Key) :- 
    complement(List,Sublist,Complement),
    my_average(List,LA), 
    my_average(Complement,CA), 
    D is LA - CA, 
    abs(D, Key).
    

test_map_sublist_helper(K) :- map_sublist_helper([22, 27, 12, 25],[16, 18, 22, 27, 12, 25, 21],K).
% K = 1.8095238095238102


% map_sublists(+Sublists, +List, -Keys)
% maps list of sublists to keys (view task.md)
map_sublists([],_,[]) :- !.
map_sublists([H|T],List,[[H,HK]|TK]) :- map_sublists(T,List,TK), map_sublist_helper(H,List,HK).

test_map_sublists(Keys) :-
    map_sublists([[16, 18, 22, 27],[18, 22, 27, 12],[22, 27, 12, 25],[27, 12, 25, 21]], [16, 18, 22, 27, 12, 25, 21], Keys).
% Keys = [[[16, 18, 22, 27], 0.8095238095238102], [[18, 22, 27, 12], 0.5238095238095255], [[22, 27, 12, 25], 1.8095238095238102], [[27, 12, 25, 21], 1.4761904761904745]]
                

% solution to the task
solution(List,N,Result) :- 
    make_sublists(List,N,Sublists), 
    map_sublists(Sublists,List,Pairs), 
    my_min_by_key(Pairs,[Result,_]).

test_solution(X) :- solution([16, 18, 22, 27, 12, 25, 21],4,X).
