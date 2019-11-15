won(_,1,Counter1):-
        Counter1 is 15.
won(Counter,0,Counter).

% =============== Auxiliary Functions ====================

playerPlay(Board , Counter , WhitePieces,NewBoard,NewWhitePieces,Counter1):-
        printBoard(Board),
        getPlay(Board , NewBoard , WhitePieces , NewWhitePieces,Win),
        won(Counter,Win,NewCounter),
        Counter1 is NewCounter + 1.

pcPlay(Board,Counter,Pieces,NewBoard,NewPieces,Counter1):-
        printBoard(Board),
        valid_moves(Board, ListOfMoves, Pieces , Piece , 1),
        choose_move( Board , 0 , X , Y , ListOfMoves),
        finishMove(Board , X , Y , Piece , Pieces , NewPieces , NewBoard),
        checkWin(NewBoard,X,Y,Win),
        won(Counter,Win,NewCounter),
        Counter1 is NewCounter + 1.


% ================ Person vs Person ======================

personVSperson(_Player, Board , 16, _WhitePieces, _BlackPieces):-
        printBoard(Board),
        write('\n Game over! \n').

% == Player 1(white) turn ==   
personVSperson(white,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        playerPlay(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        personVSperson(black,NewBoard,Counter1,NewWhitePieces,BlackPieces).

% == Player 2(black) turn ==   
personVSperson(black,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        playerPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        personVSperson(white,NewBoard,Counter1,WhitePieces,NewBlackPieces).


% ================ Person vs Computer ======================

personVSpc(_PlayerorBot,Board , 16 , _WhitePieces, _BlackPieces):-
        printBoard(Board),
        write('\n Game over!\n').

% == Person turn ==
personVSpc(player,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        player1Play(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        personVSpc(bot,NewBoard , Counter1 , NewWhitePieces, BlackPieces).

% == PC turn ==
personVSpc(bot,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        pcPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        personVSpc(player,NewBoard , Counter1 , WhitePieces, NewBlackPieces).


% ================ Computer vs Computer ======================

pcVSpc(_ ,Board , 16, _WhitePieces , _BlackPieces):-
        printBoard(Board),
        write('\n Game over!\n').

% == PC1 turn ==
pcVSpc(pc1,Board , Counter, WhitePieces , BlackPieces):-
        Counter<16,
        pcPlay(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        pcVSpc(pc2,NewBoard , Counter1, NewWhitePieces , BlackPieces).

% == PC2 turn ==
pcVSpc(pc2,Board , Counter, WhitePieces , BlackPieces):-
        Counter<16,
        pcPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        pcVSpc(pc1,NewBoard , Counter1, WhitePieces , NewBlackPieces).