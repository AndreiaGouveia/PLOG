% Boards and Pieces
initialBoard(
                [[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty],[empty,empty,empty,empty]]).
               % [[empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty],[empty,empty,empty,empty,empty]]).

piecesBlack(
        [1 , 2 , 3 , 4]
).

piecesWhite(
        [5 , 6 , 7 , 8]
).



% Tradution
piece(empty, V) :- V = '*'.
piece(1, V) :- V ='p'.
piece(5, V) :- V ='P'.
piece(2, V) :- V ='c'.
piece(6, V) :- V ='C'.
piece(3, V) :- V ='l'.
piece(7, V) :- V ='L'.
piece(4, V) :- V ='e'.
piece(8, V) :- V ='E'.

player(white , V) :- V = 1.
player(black , V) :- V = 2.



% Display functions 

showBoard(Player, Board, PlayerPieces) :- 
        player(Player,Num),
        write( '\nIt\'s player '),
        write( Num ),
        write( ' turn!\n' ),
        printBoard(Board),
        showPieces(PlayerPieces).

printBoard(Board):-
        write('\n  '),
        length(Board, X),
        printTopBoard(X,0),
        write('\n   ') ,
        printEmptyLine(X),
        printBoard(Board, 1).

printTopBoard(X,X).

printTopBoard(X,Y):-
        X>Y,
        LetterCode is Y+97,
        Y1 is Y+1,
        write('   '),
        char_code(LetterChar,LetterCode),
        write(LetterChar),
        printTopBoard(X,Y1).

printEmptyLine(0):- 
        write('|').

printEmptyLine(X):-
        X>0,
        X1 is X-1,
        write('|---'),
        printEmptyLine(X1).

printBoard([],_):-
        nl,
        nl.

printBoard([H|T],Num):-
        write('\n '),
        write(Num),
        printLine(H),
        length(H,X),
        write('\n   '),
        printEmptyLine(X),
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