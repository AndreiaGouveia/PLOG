menus:-
        displayMainMenu,
        nl,
        read(Input),
        menuChoice(Input).

menuChoice(1):-
        initialBoard(InitialBoard),
        printBoard(InitialBoard).

menuChoice(2):-
        write('Thanks for playing!').

menuChoice(_):-
        write('Must choose between 1 or 2'),
        read(Input),
        menuChoice(Input).


displayMainMenu:-
        write(' ----------------------------------------\n'),
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
