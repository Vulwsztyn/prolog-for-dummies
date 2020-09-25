% to_pairs(+List, -Pairs)
% creates pairs in a way described in task.md
to_pairs([],[]):-!.
to_pairs([H|T],[[H,Last]|Pairs]):-append(T2,[Last],T),to_pairs(T2,Pairs),!.

test_to_pairs(X) :- to_pairs([16, 18, 22, 27, 12, 25, 21, 13],X).
% X = [[16, 13], [18, 21], [22, 25], [27, 12]]


% complement(+List, +Sublist, -Complement)
% returns the list of all elements that are not in the sublist
% notice that it will not work if the leements in the list are not unique
% 	or the order of the elements of the Sublist is different in sublist and in list
complement(Orig,[],Orig).
complement([H|TOrig],[H|TSublist],Complement) :- complement(TOrig,TSublist,Complement), !.
complement([H|TOrig],Sublist,[H|Complement]) :- complement(TOrig,Sublist,Complement).

test_complement(A,B,C,D) :- complement([16, 18, 22, 27, 12, 25, 21, 13],[16, 13],A),
    complement([16, 18, 22, 27, 12, 25, 21, 13],[18, 21],B),
    complement([16, 18, 22, 27, 12, 25, 21, 13],[22, 25],C),
    complement([16, 18, 22, 27, 12, 25, 21, 13],[27, 12],D).
% A = [18, 22, 27, 12, 25, 21],
% B = [16, 22, 27, 12, 25, 13],
% C = [16, 18, 27, 12, 21, 13],
% D = [16, 18, 22, 25, 21, 13]

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

test_my_average(A,B,C,D,E) :- my_average([18, 22, 27, 12, 25, 21],A),
    my_average([16, 22, 27, 12, 25, 13],B),
    my_average([16, 18, 27, 12, 21, 13],C),
    my_average([16, 18, 22, 25, 21, 13],D),
    my_average([16, 18, 22, 27, 12, 25, 21, 13],E).
% A = 20.833333333333332,
% B = D, D = 19.166666666666668,
% C = 17.833333333333332,
% E = 19.25


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


% sublist_to_key(+Sublist, +List, -Key)
% calculates the differance between averages of the list and the complement of sublist
sublist_to_key(Sublist,List,Key) :- 
    complement(List,Sublist,Complement),
    my_average(List,LA), 
    my_average(Complement,CA),
    D is LA - CA, 
    abs(D, Key).
    

test_sublist_to_key(K1,K2,K3,K4) :- 
    sublist_to_key([16, 13],[16, 18, 22, 27, 12, 25, 21, 13],K1),
	sublist_to_key([18, 21],[16, 18, 22, 27, 12, 25, 21, 13],K2),
	sublist_to_key([22, 25],[16, 18, 22, 27, 12, 25, 21, 13],K3),
	sublist_to_key([27, 12],[16, 18, 22, 27, 12, 25, 21, 13],K4).
% K1 = 1.5833333333333321,
% K2 = K4, K4 = 0.08333333333333215,
% K3 = 1.4166666666666679

% min_by_key(+List, -MinByKey)
% assuming the list elements are arrays of length 2 containing [Value,Key] it returns the element for the minimal key
% could be called min_by_second_element
my_min_by_key([X],_,X).
my_min_by_key([H|T],List,H) :- my_min_by_key(T,List,TMin), sublist_to_key(TMin,List,TKey), sublist_to_key(H,List,HK), TKey > HK, !.
my_min_by_key([_|T],List,TMin) :-  my_min_by_key(T,List,TMin), !.

% I needed to add my because min_by_key exists in Prolog, debugging this was not rewarding

% and I wrote my_min_by_key([X],X). as my_min_by_key([X],[X]). which would result in type error in any strongly typed language

test_my_min_by_key(X) :- my_min_by_key([[16, 13], [18, 21], [22, 25], [27, 12]],[16, 18, 22, 27, 12, 25, 21],X).
% X = [27, 12]


% solution to the task
solution(List,Result) :- 
    to_pairs(List,Pairs), 
    my_min_by_key(Pairs,List,Result).

test_solution(X) :- solution([16, 18, 22, 27, 12, 25, 21, 13],X).
% X = [27, 12]

