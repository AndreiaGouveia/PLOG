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
        write(' ----------------------------------------'),
        nl,
        write('|                                        |'),
        nl,
        write('|                Quantik                 |'),
        nl,
        write('|                                        |'),
        nl,
        write('|                                        |'),
        nl,
        write('|                                        |'),
        nl,
        write('|         Options:                       |'),
        nl,
        write('|                    1- Start Game       |'),
        nl,
        write('|                    2- Exit             |'),
        nl,
        write('|                                        |'),
        nl,
        write('|                                        |'),
        nl,
        write(' ----------------------------------------'),
        nl.
