% my_min(+List, -Min).
my_min([X],X) :- !.
my_min([H|T],H) :- my_min(T,MT), MT > H, !.
my_min([_|T],MT) :- my_min(T,MT).

test_my_min(X) :- my_min([16, 18, 22, 27, 12, 25, 21],X).
% X =27


% my_max(+List, -Max).
my_max([X],X) :- !.
my_max([H|T],H) :- my_max(T,MT), MT < H, !.
my_max([_|T],MT) :- my_max(T,MT).

test_my_max(X) :- my_max([16, 18, 22, 27, 12, 25, 21],X).
% X = 27


% map_to_first(+ListOfPairs, -ListOfFirstElements)
map_to_first([],[]).
map_to_first([[H,_]|T],[H|TF]) :- map_to_first(T,TF).
test_map_to_first(X) :- map_to_first([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = [-6, -1, -5, -3, -9, -8]


% map_to_second(+ListOfPairs, -ListOfSecondElements)
map_to_second([],[]).
map_to_second([[_,H]|T],[H|TF]) :- map_to_second(T,TF).
test_map_to_second(X) :- map_to_second([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = [1, 3, 2, 5, -2, -6]


% my_range(+Start, +End, -Range)
% returns all ints between start and end inclusively
my_range(X,X,[X]) :- !.
my_range(X,Y,[X|T]) :- X1 is X + 1, my_range(X1,Y,T).

test_my_range(X) :- my_range(-9,5,X).
% X = [-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]

% flatten_pairs(+ListOfPairs, -FlatList).
flatten_pairs([],[]) :- !.
flatten_pairs([[H1,H2]|T],[H1,H2|TF]) :- flatten_pairs(T,TF).

test_flatten_pairs(X) :- flatten_pairs([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = [-6, 1, -1, 3, -5, 2, -3, 5, -9, -2, -8, -6]


% remove_value(+List, +Value, -ListWithoutValue)
remove_value([],_,[]).
remove_value([H|T],H,TF) :- remove_value(T,H,TF), !.
remove_value([H|T],V,[H|TF]) :- remove_value(T,V,TF).

test_remove_value(X) :- remove_value([1,2,3,2,4,5,2,6,4,7,2],2,X).
% X = [1, 3, 4, 5, 6, 7]


% remove_values(+List, +ListOfValues, -ListWithoutValues)
remove_values(List,[],List) :- !.
remove_values(List,[H|T],ListF) :- 
    remove_value(List,H,ListWithoutH), 
    remove_values(ListWithoutH,T,ListF).

test_remove_values(X) :- remove_values([1,2,3,2,4,5,2,6,4,7,2],[2,4],X).
% X = [1, 3, 5, 6, 7]


% is_inside(+Elem, +Interval)
% this one is tricky, it doesn't "return" anything it just "is"
is_inside(N,[S,G]) :- N > S, N < G.
%%% Do przerobienia
test_is_inside_1('3 is in the interval') :- is_inside(3,[2,4]).
test_is_inside_2('3 is not in the interval') :- not(is_inside(3,[3,6])).


% leave_only_including(+Number, +Intervals, -IntervalsContainingNumber)
leave_only_including(_,[],[]).
leave_only_including(N,[H|T],[H|T2]) :- is_inside(N,H), leave_only_including(N,T,T2), !.
leave_only_including(N,[_|T],T2) :- leave_only_including(N,T,T2).

test_leave_only_including(X) :- leave_only_including(3,[[1,2],[1,3],[2,3],[2,4],[1,5],[3,7],[0,4]],X).
% X = [[2, 4], [1, 5], [0, 4]]

% intervals_to_range(+Intervals, -Range)
% returns all integers within the domain of the list of intervals
intervals_to_range(L,R) :- 
    map_to_first(L,F), 
    map_to_second(L,S),
    my_min(F,Min),
    my_max(S,Max),
    my_range(Min,Max,R).

test_intervals_to_range(X) :- intervals_to_range([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = [-9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]


% create_list_of_valid_ints((+ListOfIntervals, -ListOfValidInts)
% returns list of insts inside the domain of the intervals but not on the verge of any interval
create_list_of_valid_ints(L,Valid) :- 
    intervals_to_range(L,Ints),
    flatten_pairs(L,Flat),
    remove_values(Ints,Flat,Valid).

test_create_list_of_valid_ints(X) :- create_list_of_valid_ints([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = [-7, -4, 0, 4]

% how_many_include(+Number, +ListOfIntervals, -IncludingCount)
how_many_include(N,L,C) :- leave_only_including(N,L,I), length(I,C).

test_how_many_include(A,B,C,D) :- 
    how_many_include(-7,[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],A),
    how_many_include(-4,[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],B),
    how_many_include(0,[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],C),
    how_many_include(4,[[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],D).
% A = 2,
% B = 3,
% C = 4,
% D = 1

% max_by_including(+ListOfNumbers, +ListOfIntervals, -NumberInMostIntervals)
max_by_including([X],_,X).
max_by_including([H|T],L,H) :- 
    max_by_including(T,L,TM), 
    how_many_include(H,L,HI), 
    how_many_include(TM,L,TI), 
    HI > TI,
    !.
max_by_including([_|T],L,TM) :- 
    max_by_including(T,L,TM). 

test_max_by_including(X) :- max_by_including([-7, -4, 0, 4], [[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]], X).
% X = 0

solution(L,Result) :- create_list_of_valid_ints(L,Valid), max_by_including(Valid,L,Result).

test_solution(X) :- solution([[-6,1],[-1,3],[-5,2],[-3,5],[-9,-2],[-8,-6]],X).
% X = 0


