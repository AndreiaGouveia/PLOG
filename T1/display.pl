% Boards and Pieces
initialBoard(
                [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]).

piecesBlack(
        [1 , 1 , 2 , 2 , 3 , 3 , 4 , 4]
).

piecesWhite(
        [6 , 6 , 7 , 7 , 8 , 8 , 9 , 9]
).



% Tradution
piece(0, V) :- V = '*'.
piece(1, V) :- V ='p'.
piece(6, V) :- V ='P'.
piece(2, V) :- V ='c'.
piece(7, V) :- V ='C'.
piece(3, V) :- V ='l'.
piece(8, V) :- V ='L'.
piece(4, V) :- V ='e'.
piece(9, V) :- V ='E'.

player(white , V) :- V = 1.
player(black , V) :- V = 2.



% Display functions 

showBoard(Player, Board, PlayerPieces) :- 
        player(Player,Num),
        write( '\nIt\'s player '),
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

% Prints the pieces that are still available

isEmpty([]).

showPieces(PlayerPieces ):-
        isEmpty(PlayerPieces),
        !,
        write('\n Error: there are no more available pieces :( \n').

showPieces(PlayerPieces ):-
        write('\n Player\'s available pieces: \n'),
        printLine(PlayerPieces),
        nl.