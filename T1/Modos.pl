% ================ Person vs Person ======================

initGame(_ , 16, _, _):-
        write('\n Game over!\n').
       
initGame(0,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        whitePlay(Board,Counter,WhitePieces,NewBoard,NewWhitePieces,Counter1),
        initGame(1,NewBoard,Counter1,NewWhitePieces,BlackPieces).

initGame(1,Board , Counter , WhitePieces, BlackPieces):-
        Counter<16,
        blackPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1),
        initGame(0,NewBoard,Counter1,WhitePieces,NewBlackPieces).

whitePlay(Board , Counter , WhitePieces,NewBoard,NewWhitePieces,Counter1):-
        showBoard(white,Board, WhitePieces),
        getPlay(Board , white , NewBoard , WhitePieces , NewWhitePieces),
        Counter1 is Counter + 1.

blackPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1):-
        showBoard(black,Board,BlackPieces),
        getPlay(Board , black , NewBoard , BlackPieces , NewBlackPieces),
        Counter1 is Counter + 1.

% ================ Person vs Computer ======================




% ================ Computer vs Computer ======================