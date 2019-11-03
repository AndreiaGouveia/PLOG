% Boards and Pieces
initialBoard(
                [[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty]]).

piecesBlack(
        [cubeB , coneB , cylinderB , sphereB]
).

piecesWhite(
        [cubeW , coneW , cylinderW , sphereW]
).



% Tradution
piece(empty, V) :- V = '*'.
piece(coneB, V) :- V ='p'.
piece(coneW, V) :- V ='P'.
piece(cubeB, V) :- V ='c'.
piece(cubeW, V) :- V ='C'.
piece(cylinderB, V) :- V ='l'.
piece(cylinderW, V) :- V ='L'.
piece(sphereB, V) :- V ='e'.
piece(sphereW, V) :- V ='E'.

player(white , V) :- V = 1.
player(black , V) :- V = 2.



% Display functions 

showBoard(Player, Board, PlayerPieces) :- 
        player(Player,Num),
        write( 'It\'s player '),
        write( Num ),
        write( 'turn!\n' ),
        printBoard(Board),
        showPieces(PlayerPieces).

printBoard(Board):-
        write('\n     a   b   c   d  '),
        write('\n   |---|---|---|---|') ,
        printBoard(Board, 1).

printBoard([],_):-
        nl,
        nl.

printBoard([H|T],Num):-
        write('\n '),
        write(Num),
        printLine(H),
        nl,
        write('   |---|---|---|---|'),
        Num1 is Num+1,
        printBoard(T,Num1).

printLine([]):-
        write(' |').

printLine([H|T]):-
        write(' | '),
        piece(H,Piece),
        write(Piece),
        printLine(T).

showPieces(PlayerPieces ):-
        write('\n Player\'s available pieces: \n'),
        printLine(PlayerPieces).