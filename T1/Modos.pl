% ================ Person vs Person ======================

initGame(Board , 16):-
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