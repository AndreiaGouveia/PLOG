% ================ Person vs Person ======================

personVSperson(Board , 8 , WhitePieces , _BlackPieces):-
        showBoard(white,Board, WhitePieces),
        write('\n Game over!\n').
       
personVSperson(Board , Counter , WhitePieces, BlackPieces):-
        showBoard(white,Board, WhitePieces),
        getPlay(Board , white , NewBoard , WhitePieces , NewWhitePieces),
        Counter1 is Counter + 1,
        showBoard(black,NewBoard,BlackPieces),
        getPlay(NewBoard , black , NewBoard1 , BlackPieces , NewBlackPieces),
        personVSperson(NewBoard1 , Counter1 , NewWhitePieces , NewBlackPieces).

% ================ Person vs Computer ======================
personVSpc(Board , 8 , WhitePieces, _BlackPieces):-
        showBoard(white,Board, WhitePieces),
        write('\n Game over!\n').

personVSpc(Board , Counter , WhitePieces, BlackPieces):-
        % == Person turn ==
        showBoard(white,Board, WhitePieces),
        getPlay(Board , white , NewBoard , WhitePieces , NewWhitePieces),
        showBoard(black,NewBoard,BlackPieces),

        % == PC turn ==
        valid_moves(NewBoard, ListOfMoves1, BlackPieces , Piece1 , 1),
        choose_move( NewBoard , 0 , X1 , Y1 , ListOfMoves1),
        finnishMove(NewBoard , X1 , Y1 , Piece1 , BlackPieces , NewBlackPieces , NewBoard1),

        Counter1 is Counter + 1,
        personVSpc(NewBoard1 , Counter1 , NewWhitePieces , NewBlackPieces).


% ================ Computer vs Computer ======================

pcVSpc(Board , 8, WhitePieces , _BlackPieces):-
        showBoard(white,Board, WhitePieces),
        write('\n Game over!\n').

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