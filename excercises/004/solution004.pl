% reverse_range(+Number, -List)
% returns list of ints from Number to 1
reverse_range(0,[]) :- !.
reverse_range(N,[N|T]) :- N1 is N - 1, reverse_range(N1,T).

test_reverse_range(X) :- reverse_range(15,X).
% X = [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

my_factors_from_list(0,_,[]) :- !.
my_factors_from_list(N,[H|T],[H|TFactors]) :- 
    N >= H * H, 
    N1 is N - (H * H),
    my_factors_from_list(N1,[H|T],TFactors),
    !.
my_factors_from_list(N,[_|T],TFactors) :-
    my_factors_from_list(N,T,TFactors).

% notice that I pass [H|T] and not H in the second line as e.g. 18 = 3^2 + 3^2
% I forgot = in N >= H * H so remember that it is a possible mistake

test_my_factors_from_list(X,Y,Z) :- 
    my_factors_from_list(15,[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1],X),
    my_factors_from_list(22,[22, 21, 20, 19, 18, 17, 16 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1],Y),
    my_factors_from_list(25,[25, 24, 23, 22, 21, 20, 19, 18, 17, 16 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1],Z).
% X = [3, 2, 1, 1],
% Y = [4, 2, 1, 1],
% Z = [5]


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


% number_to_key(+Number, -Key)
number_to_key(N,K) :- 
    reverse_range(N,R), 
    my_factors_from_list(N,R,F),
    my_average(F,K).

test_number_to_key(X,Y,Z) :-
    number_to_key(15,X),
    number_to_key(22,Y),
	number_to_key(25,Z).

% X = 1.75,
% Y = 2,
% Z = 5

% max_by_key(+List, -ElemThatGivesMaxKey)
max_by_key([X],X) :- !.
max_by_key([H|T],H) :- 
    max_by_key(T,TM),
    number_to_key(TM,KT),
    number_to_key(H,HK),
    HK > KT,
    !.
max_by_key([_|T],TM) :- 
    max_by_key(T,TM).
    
test_max_by_key(X) :- max_by_key([15,22,33],X).

solution(X,Y) :- max_by_key(X,Y).














