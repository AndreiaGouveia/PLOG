% ================ Person vs Person ======================

initGame(_Board , 16 , _WhitePieces , _BlackPieces):-
        write('\n Game over!\n').
       
initGame(Board , Counter , WhitePieces, BlackPieces):-
        showBoard(white,Board, WhitePieces),
        getPlay(Board , white , NewBoard , WhitePieces , NewWhitePieces),
        Counter1 is Counter + 1,
        showBoard(black,NewBoard,BlackPieces),
        getPlay(NewBoard , black , NewBoard1 , BlackPieces , NewBlackPieces),
        Counter2 is Counter1 + 1,
        initGame(NewBoard1 , Counter2 , NewWhitePieces , NewBlackPieces).

% ================ Person vs Computer ======================




% ================ Computer vs Computer ======================

pcVSpc(Board , 15, WhitePieces , BlackPieces).

pcVSpc(Board , Counter, WhitePieces , BlackPieces):-
        % == first player ==
        showBoard(white, Board, WhitePieces),
        valid_moves(Board, ListOfMoves, WhitePieces , Piece , 1),
        choose_move( Board, 0, X , Y , ListOfMoves),
        finnishMove(Board , X , Y , Piece , WhitePieces , NewWhitePieces , NewBoard),

        % == second player ==
        showBoard(black , NewBoard , BlackPieces),
        valid_moves(NewBoard, ListOfMoves1, BlackPieces , Piece1 , 1),
        choose_move( NewBoard , 0 , X1 , Y1 , ListOfMoves1),
        finnishMove(NewBoard , X1 , Y1 , Piece1 , BlackPieces , NewBlackPieces , NewBoard1),

        Counter1 is Counter + 1,
        pcVSpc(NewBoard1 , Counter1 , NewWhitePieces , NewBlackPieces).