initialBoard(
                [[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty]]).

printBoard(Board):-write('  ----------------') , printLines(Board).

piece(empty, V) :- V = '*'.
piece(coneB, V) :- V ='p'.
piece(coneW, V) :- V ='P'.
piece(cubeB, V) :- V ='c'.
piece(cubeW, V) :- V ='C'.
piece(cylinderB, V) :- V ='l'.
piece(cylinderW, V) :- V ='L'.
piece(sphereB, V) :- V ='e'.
piece(sphereW, V) :- V ='E'.



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
        piece(H,Piece),
        write(Piece),
        printColumn(T).
