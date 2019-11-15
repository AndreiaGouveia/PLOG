menus:- % First Menu
        repeat,
        displayMainMenu,
        nl,
        read_line([H|T]),
        length(T,0),
        H >= 48, H =< 57, %//TODO delete this? its optional, forces between 0-9
        !,
        Input is H-48,
        menuChoice(Input).

menuChoice(1):- % start game
        initialBoard(InitialBoard),
        length(InitialBoard, X),
        X1 is X-2,
        piecesBlack(BlackPieces,X1),
        piecesWhite(WhitePieces,X1),
        repeat,
        displayGameMenu,
        nl,
        read_line([H|T]),
        length(T,0),
        !,
        Input is H-48,
        gameChoice(Input , InitialBoard , BlackPieces , WhitePieces).

menuChoice(2):- % exitgame
        write('Thanks for playing!').

menuChoice(_):- % invalid input
        write('Must choose between 1 or 2\n'),
        menus.

% ========== Init game option ==================
gameChoice(1 , InitialBoard , BlackPieces , WhitePieces):- personVSperson(0,InitialBoard , 0, WhitePieces , BlackPieces) , menus. % person vs person
gameChoice(2 , InitialBoard , BlackPieces , WhitePieces):- personVSpc(0,InitialBoard , 0 , WhitePieces, BlackPieces) , menus. % person vs pc
gameChoice(3 , InitialBoard , BlackPieces , WhitePieces):-  pcVSpc(0,InitialBoard, 0 , WhitePieces , BlackPieces) , menus. % pc vs pc
gameChoice(_ , _InitialBoard , _BlackPieces , _WhitePieces):- menuChoice(1). % invalid input

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
