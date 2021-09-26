% graph(+CurrentValue, +LastSign, +Slashes, -Result)
graph(_, _, [], []) :- !.
graph(N, /, [/|T], [N1|T2]) :-
    N1 is N + 1,
    graph(N1, /, T, T2),
    !.
graph(N, \, [\|T], [N1|T2]) :-
    N1 is N - 1,
    graph(N1, \, T, T2),
    !.
graph(N, _, [H|T], [N|T2]) :-
    graph(N, H, T, T2).

test_graph(X) :- graph(0, /, [/, /, \, \, \, \, /, /, \, \, \, \, /, /, /, \], X).
% X = [1, 2, 2, 1, 0, -1, -1, 0, 0, -1, -2, -3, -3, -2, -1, -1]

get_graph([H|T], Y) :- graph(0, H, [H|T], Y).

test_get_graph(X) :- get_graph([/, /, \, \, \, \, /, /, \, \, \, \, /, /, /, \], X).
% X = [1, 2, 2, 1, 0, -1, -1, 0, 0, -1, -2, -3, -3, -2, -1, -1]


solution(X) :- get_graph([/, /, \, \, \, \, /, /, \, \, \, \, /, /, /, \], X).
% X = [1, 2, 2, 1, 0, -1, -1, 0, 0, -1, -2, -3, -3, -2, -1, -1]