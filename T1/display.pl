initialBoard(
                [[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty]]).

printBoard(Board):-
        write('\nL\\C 1   2   3   4  '),
        write('\n  |---|---|---|---|') ,
        printColumns(Board, 1).

piece(empty, V) :- V = '*'.
piece(coneB, V) :- V ='p'.
piece(coneW, V) :- V ='P'.
piece(cubeB, V) :- V ='c'.
piece(cubeW, V) :- V ='C'.
piece(cylinderB, V) :- V ='l'.
piece(cylinderW, V) :- V ='L'.
piece(sphereB, V) :- V ='e'.
piece(sphereW, V) :- V ='E'.



printColumns([],_):-
        nl,nl.

printColumns([H|T],Num):-
        nl,
        write(Num),
        printLine(H),
        nl,
        write('  |---|---|---|---|'),
        Num1 is Num+1,
        printColumns(T,Num1).

printLine([]):-
        write(' |').

printLine([H|T]):-
        write(' | '),
        piece(H,Piece),
        write(Piece),
        printLine(T).
