initialBoard(
                [[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty]]).

printBoard(Board):-
        write('\n    A   B   C   D  '),
        write('\n  |---|---|---|---|') ,
        printBoard(Board, 1).

piece(empty, V) :- V = '*'.
piece(coneB, V) :- V ='p'.
piece(coneW, V) :- V ='P'.
piece(cubeB, V) :- V ='c'.
piece(cubeW, V) :- V ='C'.
piece(cylinderB, V) :- V ='l'.
piece(cylinderW, V) :- V ='L'.
piece(sphereB, V) :- V ='e'.
piece(sphereW, V) :- V ='E'.



printBoard([],_):-
        nl,nl.

printBoard([H|T],Num):-
        nl,
        write(Num),
        printLine(H),
        nl,
        write('  |---|---|---|---|'),
        Num1 is Num+1,
        printBoard(T,Num1).

printLine([]):-
        write(' |').

printLine([H|T]):-
        write(' | '),
        piece(H,Piece),
        write(Piece),
        printLine(T).
