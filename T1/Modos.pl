% ================ Person vs Person ======================
won(_,1,Counter1):-
        Counter1 is 15.
won(Counter,0,Counter).

initGame(_, _ , 16, _, _):-
        write('\n Game over! \n').
       
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
        getPlay(Board , white , NewBoard , WhitePieces , NewWhitePieces,X),
        won(Counter,X,NewCounter),
        Counter1 is NewCounter + 1.

blackPlay(Board,Counter,BlackPieces,NewBoard,NewBlackPieces,Counter1):-
        showBoard(black,Board,BlackPieces),
        getPlay(Board , black , NewBoard , BlackPieces , NewBlackPieces,X),
        won(Counter,X,NewCounter),
        Counter1 is NewCounter + 1.

% ================ Person vs Computer ======================




% ================ Computer vs Computer ======================