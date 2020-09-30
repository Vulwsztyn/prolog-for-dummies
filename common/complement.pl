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


% remove_list(+List: [a], +List2: [a], -ListWithoutList2: [a])
remove_list(L,[],L).
remove_list(L,[H|T],LW) :-
    remove_one(L,H,LwithoutH),
    remove_list(LwithoutH,T,LW),
    !.

test_remove_list(X) :- remove_list([4,5,8,9,5,2,4,0,4,2,5,7],[4,5],X).
% X = [8, 9, 2, 0, 2, 7]

% remove_list can be used to get the complement of sublist in a list e.g. remove_list([1,2,3,4,5],[3,4,5],X).
