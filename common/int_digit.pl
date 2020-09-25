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