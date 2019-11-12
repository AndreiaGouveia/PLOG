menus:- % First Menu
        displayMainMenu,
        nl,
        read(Input),
        menuChoice(Input).

menuChoice(1):- % start game
        initialBoard(InitialBoard),
        length(InitialBoard, X),
        X1 is X-2,
        piecesBlack(BlackPieces,X1),
        piecesWhite(WhitePieces,X1),
        displayGameMenu,
        nl,
        read(Input),
        gameChoice(Input , InitialBoard , BlackPieces , WhitePieces).

menuChoice(2):- % exitgame
        write('Thanks for playing!').

menuChoice(_):- % invalid input
        write('Must choose between 1 or 2\n'),
        read(Input),
        menuChoice(Input).


% ========== Init game option ==================
gameChoice(1 , InitialBoard , BlackPieces , WhitePieces):- initGame(InitialBoard , 0, WhitePieces , BlackPieces) , menus. % person vs person
gameChoice(2 , _InitialBoard , _BlackPieces , _WhitePieces):- write('\n Not yet implemented! \n') , menus. % person vs pc
gameChoice(3 , _InitialBoard , _BlackPieces , _WhitePieces):- write('\n Not yet implemented! \n') , menus. % pc vs pc
gameChoice(_ , _InitialBoard , _BlackPieces , _WhitePieces):- menus. % invalid input

% ============= Menus Display =====================
displayMainMenu:-
        write('\n ----------------------------------------\n'),
        write('|                                        |\n'),
        write('|                Quantik                 |\n'),
        write('|                                        |\n'),
        write('|                                        |\n'),
        write('|                                        |\n'),
        write('|         Options:                       |\n'),
        write('|                    1- Start Game       |\n'),
        write('|                    2- Exit             |\n'),
        write('|                                        |\n'),
        write('|                                        |\n'),
        write(' ----------------------------------------\n').

displayGameMenu:-
        write('\n ------------------------------------------\n'),
        write('|                                            |\n'),
        write('|                   Quantik                  |\n'),
        write('|                                            |\n'),
        write('|                                            |\n'),
        write('|                                            |\n'),
        write('|         Options:                           |\n'),
        write('|                    1- Person vs Person     |\n'),
        write('|                    2- Computer vs Person   |\n'),
        write('|                    3- Computer vs Computer |\n'),
        write('|                                            |\n'),
        write('|                                            |\n'),
        write(' --------------------------------------------\n').
