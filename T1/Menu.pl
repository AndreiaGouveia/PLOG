menus:-
displayMainMenu,
nl,
read(Input),
menuChoice(Input).

menuChoice(0):-
initialBoard(InitialBoard),
printBoard(InitialBoard).

menuChoice(1):-
write('Thanks for playing!').

menuChoice(Undefined):-
write('Must choose between 0 or 1'),
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
