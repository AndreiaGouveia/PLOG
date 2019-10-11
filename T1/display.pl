initialBoard(
                [['*','*','*','*'],['*','*','*','*'],['*','*','*','*'],['*','*','*','*']]).

printBoard(Board):-write('  ----------------') , printLines(Board).

printLines([]):-
        nl.

printLines([H|T]):-
        nl,
        printColumn(H),
        nl,
        write(' |---|---|---|---|'),
        printLines(T).

printColumn([]):-
        write(' |').

printColumn([H|T]):-
        write(' | '),
        write(H),
        printColumn(T).
