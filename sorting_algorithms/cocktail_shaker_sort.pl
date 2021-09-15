% swap_up(+List, -ListWithMovedElement)
% goes through the list
% checks every two adjacent numbers
% if the first is greater, then swap them
% in other words, the biggest element is moved to position where after its there are only greater numbers.
swap_up([], []).
swap_up([X], [X]).
swap_up([Fst, Snd|T], [Snd|L]) :- Fst > Snd, swap_up([Fst|T], L), !.
swap_up([Fst, Snd|T], [Fst|L]) :- swap_up([Snd|T], L).

test_swap_up(X) :- swap_up([4, 3, 2, 1], X).
% X = [3, 2, 1, 4]


% swap_down(+List, -ListWithMovedElement)
% goes through the list
% checks every two adjacent numbers
% if the first is smaller, then swap them
% in other words, the smallest element is moved to position where after its there are only smaller numbers.
swap_down([], []).
swap_down([X], [X]).
swap_down([Fst, Snd|T], [Snd|L]) :- Fst < Snd, swap_down([Fst|T], L), !.
swap_down([Fst, Snd|T], [Fst|L]) :- swap_down([Snd|T], L).

test_swap_down(X) :- swap_down([1, 2, 3, 4], X).
% X = [2, 3, 4, 1]


% reverse(+List, -ReversedList)
% reverses the list
% on every level of recursion current head is added to the end of tail
reverse([], []).
reverse([H|T], L) :- reverse(T, L1), append(L1, [H], L).

test_reverse(X) :- reverse([1, 2, 3, 4], X).
% X = [4, 3, 2, 1]


% cocktail_shaker_sort(+List, -SortedList)
% sorts the list
% firstly swap_up and reverse combined allows to get the biggest number and work on the rest of the list
% while you have reversed list, you can also get the smallest number with swap_down and omit it in later computations
% after that you need to restore the old order and run recursively function for the elements left in the list.
cocktail_shaker_sort([], []).
cocktail_shaker_sort([X], [X]).
cocktail_shaker_sort(L, S) :- 
    swap_up(L, L1), 
    reverse(L1, [Biggest|L2]), 
    swap_down(L2, L3), 
    reverse(L3, [Smallest|L4]), 
    cocktail_shaker_sort(L4, S1), 
    append([Smallest|S1], [Biggest], S), 
    !.
test_cocktail_shaker_sort(X) :- cocktail_shaker_sort([1, 4, 2, 3], X).
% X = [1, 2, 3, 4]
