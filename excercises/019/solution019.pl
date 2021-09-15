% run_all_give_the_same_reminder(+Divisor, +Reminder, +List).
run_all_give_the_same_reminder(_, _, []) :- !.
run_all_give_the_same_reminder(D, R, [H|T]) :-
    R is mod(H, D),
    run_all_give_the_same_reminder(D, R, T).

test_run_all_give_the_same_reminder('dajo') :- run_all_give_the_same_reminder(5, 2, [12, 22, 27]).


% all_give_the_same_reminder( +Divisor, +List)
all_give_the_same_reminder(D, [H|T]) :-
    R is mod(H, D),
	run_all_give_the_same_reminder(D, R, T).

test_all_give_the_same_reminder('dajo') :- all_give_the_same_reminder(5, [12, 22, 27]).

% find_largest_giving_the_same_reminder(+StartFrom, +List, -Divisor)
run_find_largest_giving_the_same_reminder(D, L, D) :-
    all_give_the_same_reminder(D, L),
    !.
run_find_largest_giving_the_same_reminder(D, L, R) :-
    D2 is D - 1,
    run_find_largest_giving_the_same_reminder(D2, L, R).

test_run_find_largest_giving_the_same_reminder(X) :- run_find_largest_giving_the_same_reminder(20, [12, 22, 27], X).
% X = 5

find_largest_giving_the_same_reminder([H|T], D) :-
    run_find_largest_giving_the_same_reminder(H, [H|T], D).
    
test_find_largest_giving_the_same_reminder(X) :- find_largest_giving_the_same_reminder([12, 22, 27], X).
% X = %

to_key(X, Y) :- find_largest_giving_the_same_reminder(X, Y).

pivoting(_, [], [], []) :- !.
pivoting(P, [H|T], [H|L], G) :-
    pivoting(P, T, L, G), 
    to_key(H, HKey),
    to_key(P, PKey),
    HKey =< PKey,
    !.
pivoting(P, [H|T], L, [H|G]) :- 
    pivoting(P, T, L, G).


% quick_sort(+List: [a], -SortedList: [a])
quick_sort([], []) :- !.
quick_sort([H|T], Sorted):-
    pivoting(H, T, L, G), 
    quick_sort(L, SortedL), 
    quick_sort(G, SortedG),
    append(SortedL, [H|SortedG], Sorted),
    !.
