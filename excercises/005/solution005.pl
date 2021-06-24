% int_to_list_of_digits(+Int, -ListOfDigits)
int_to_list_of_digits(0,[]) :- !.
int_to_list_of_digits(N,Result) :- 
    NMod10 is N mod 10, 
    NBy10 is N // 10,
    int_to_list_of_digits(NBy10,PartialResult),
    append(PartialResult,[NMod10],Result).

% notice [NMod10] in the append as append concatenates 2 lists and not adds "bare" elements to a list

test_int_to_list_of_digits(X) :- int_to_list_of_digits(123,X).
% X = [1, 2, 3]

% map_ints_to_lists_of_digits(+ListOfInts, -ListOfListsOfDigits)
% no ! required - decided experimentally
map_ints_to_lists_of_digits([],[]).
map_ints_to_lists_of_digits([H|T],[HM|TM]) :- 
    map_ints_to_lists_of_digits(T,TM), 
    int_to_list_of_digits(H,HM).

% notice that the second line could have be written:
% map_ints_to_lists_of_digits([H|T],[HM|TM]) :- 
%    int_to_list_of_digits(H,HM),
%    map_ints_to_lists_of_digits(T,TM).
% because both H and T are defined and there is no dependency between the usages of first and second predicate


test_map_ints_to_lists_of_digits(X) :- map_ints_to_lists_of_digits([623, 278, 4231, 739, 38],X).
% X = [[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]]

% my_flatten_list(+ListOfLists, -FlatList)
my_flatten_list([],[]).
my_flatten_list([H|T],F) :- my_flatten_list(T,TF), append(H,TF,F).

test_my_flatten_list(X) :- my_flatten_list([[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]],X).
% X = [6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8]


% my_max(+List, -Max).
my_max([X],X) :- !.
my_max([H|T],H) :- my_max(T,MT), MT < H, !.
my_max([_|T],MT) :- my_max(T,MT).

test_my_max(X) :- my_max([16, 18, 22, 27, 12, 25, 21],X).
% X = 27


% rotate(+List, -RotatedListWithMaxInTheMiddle)
% returns list if Max is in the middle, else moves head of the list to the back and checks again
rotate(L,L) :- 
    my_max(L,M), 
    append(L1,[M|L2],L),
    length(L1,Len1),
    length(L2,Len2),
    Len1 =:= Len2,
    !.
rotate([H|T],R) :-
    append(T,[H],L),
    rotate(L,R).

test_rotate(X) :- rotate([6, 2, 3, 2, 7, 8, 4, 2, 3, 1, 7, 3, 9, 3, 8],X).
% X = [8, 4, 2, 3, 1, 7, 3, 9, 3, 8, 6, 2, 3, 2, 7]
                                
                                
% nest_in_the_same_way(+FlatList, +NestedList, -FlatListNestedAsNestedList)
nest_in_the_same_way([],[],[]).
nest_in_the_same_way(Flat,[HN|TN],[L1|FNested]) :-
    append(L1,L2,Flat),
    length(HN,LenHN),
    length(L1,Len1),
    Len1 =:= LenHN,
    nest_in_the_same_way(L2,TN,FNested),
    !.
           
test_nest_in_the_same_way(X) :- nest_in_the_same_way(
                                    [8, 4, 2, 3, 1, 7, 3, 9, 3, 8, 6, 2, 3, 2, 7], 
                                    [[6, 2, 3], [2, 7, 8], [4, 2, 3, 1], [7, 3, 9], [3, 8]],
                                    X).
% X = [[8, 4, 2], [3, 1, 7], [3, 9, 3, 8], [6, 2, 3], [2, 7]]
                                
                                
% list_of_digits_to_number(+ListOfDigits, -Number)
list_of_digits_to_number([],0).
list_of_digits_to_number(L,N) :-
    append(Init,[Last],L),
	list_of_digits_to_number(Init,N1),
    N is N1 * 10 + Last,
    !.  

% it is much easier to do this way than [H|T] because you would need to check length of T to know what power of 10 to multiply H by

test_list_of_digits_to_number(X) :- list_of_digits_to_number([6, 2, 3],X).
% X = 623
        

% list_of_lists_of_digits_to_ints(+ListOfListsOfDigits, -ListOfInts)
list_of_lists_of_digits_to_ints([],[]).
list_of_lists_of_digits_to_ints([H|T],[HM|TM]) :-
    list_of_lists_of_digits_to_ints(T,TM),
    list_of_digits_to_number(H,HM).

test_list_of_lists_of_digits_to_ints(X) :- list_of_lists_of_digits_to_ints([[8, 4, 2], [3, 1, 7], [3, 9, 3, 8], [6, 2, 3], [2, 7]],X).
% X = [842, 317, 3938, 623, 27]


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


% I will do this in the simplest way that comes to my mind now
% but nevertheless it might seem (and be) counterintuitive


% abs_diff_between_lists(+List1, +List2, -AbsDiff)
abs_diff_between_lists([],[],[]).
abs_diff_between_lists([H1|T1],[H2|T2],[HD|TD]) :-
    abs_diff_between_lists(T1,T2,TD),
    D is H1-H2,
    my_abs(D,HD).

test_abs_diff_between_lists(X) :- abs_diff_between_lists([623, 278, 4231, 739, 38],[842, 317, 3938, 623, 27],X).
% X = [219, 39, 293, 116, 11]


% list_to_keys(+List, -Keys)
list_to_keys(L,K) :- 
    map_ints_to_lists_of_digits(L,LD),
    my_flatten_list(LD,LF),
    rotate(LF,LR),
    nest_in_the_same_way(LR,LD,LN),
    list_of_lists_of_digits_to_ints(LN,LI),
    abs_diff_between_lists(L,LI,K).

% notice LD in nest_in_the_same_way(LR,LD,LN)

test_list_to_keys(X) :- list_to_keys([623, 278, 4231, 739, 38],X).

% X = [219, 39, 293, 116, 11]


% my_max_with_index(+List, -Max).
my_max_with_index([X],X,0).
my_max_with_index([H|T],H,0) :- my_max_with_index(T,MT,_), MT < H, !.
my_max_with_index([_|T],MT,N) :- my_max_with_index(T,MT,N1), N is N1 +1.

test_my_max_with_index(X,I) :- my_max_with_index([219, 39, 293, 116, 11],X,I).
% I = 2,
% X = 293


% at_index(+List, +Index, -ElemAtIndex)
at_index([H|_],0,H) :- !.
at_index([_|T],N,X) :- 
    N1 is N -1,
    at_index(T,N1,X).

test_at_index(X) :- at_index([10,20,30,40],2,X).
% X = 30


solution(L,R) :-
    list_to_keys(L,K),
    my_max_with_index(K,_,I),
    at_index(L,I,R).

test_solution(R) :- solution([623, 278, 4231, 739, 38],R). 
% X = 4231