% =============== Auxiliary Functions ====================

playerPlay(Board , Counter , Pieces,NewBoard,NewPieces,Counter1):-
        printBoard(Board),
        showPieces(Pieces),
        getPlay(Board , NewBoard , Pieces , NewPieces),
        game_over(NewBoard,Counter,NewCounter),
        Counter1 is NewCounter + 1.

pcPlay(Smart,Board,Counter,Pieces,NewBoard,NewPieces,Counter1):-
        printBoard(Board),
        showPieces(Pieces),
        valid_moves(Board, [], Pieces , ListOfMoves),
        choose_move( Board , Smart, X , Y, Piece, ListOfMoves),
        finishMove(Board , X , Y , Piece , Pieces , NewPieces , NewBoard),
        game_over(NewBoard,Counter,NewCounter),
        Counter1 is NewCounter + 1.


% ================ Person vs Person ======================

personVSperson(_Player, Board , 16, _WhitePieces, _BlackPieces):-
        printBoard(Board),
        write('\n Game over! \n').

% == Player 1(white) turn ==   
personVSperson(white,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        turn(white),
        playerPlay(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        personVSperson(black,NewBoard,Counter1,NewWhitePieces,BlackPieces).

% == Player 2(black) turn ==   
personVSperson(black,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        turn(black),
        playerPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        personVSperson(white,NewBoard,Counter1,WhitePieces,NewBlackPieces).


% ================ Person vs Computer ======================

personVSpc(_Smart,_PlayerorBot,Board , 16 , _WhitePieces, _BlackPieces):-
        printBoard(Board),
        write('\n Game over!\n').

% == Person turn ==
personVSpc(Smart,player,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        turn(white),
        playerPlay(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        personVSpc(Smart,bot,NewBoard , Counter1 , NewWhitePieces, BlackPieces).

% == PC turn ==
personVSpc(Smart,bot,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        turn(black),
        pcPlay(Smart,Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        personVSpc(Smart,player,NewBoard , Counter1 , WhitePieces, NewBlackPieces).


% ================ Computer vs Computer ======================

pcVSpc(_Smart, _Pc ,Board , 16, _WhitePieces , _BlackPieces):-
        printBoard(Board),
        write('\n Game over!\n').

% == PC1 turn ==
pcVSpc(Smart,pc1,Board , Counter, WhitePieces , BlackPieces):-
        Counter<16,
        turn(white),
        pcPlay(Smart,Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        pcVSpc(Smart,pc2,NewBoard , Counter1, NewWhitePieces , BlackPieces).

% == PC2 turn ==
pcVSpc(Smart,pc2,Board , Counter, WhitePieces , BlackPieces):-
        Counter<16,
        turn(black),
        pcPlay(Smart,Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        pcVSpc(Smart,pc1,NewBoard , Counter1, WhitePieces , NewBlackPieces).