initialBoard(Board):- Board=
[['*','*','*','*'],['*','*','*','*'],['*','*','*','*'],['*','*','*','*']].

lol(S):- board(V).

board(V):- initialBoard(V), write('  ----------------'),printBoard(V).

printBoard([]):-
nl.

printBoard([H|T]):-
nl,
printLine(H),
nl,
write(' |---|---|---|---|'),
printBoard(T).


printLine([]):-
write(' |').

printLine([H|T]):-
write(' | '),
write(H),
printLine(T).



