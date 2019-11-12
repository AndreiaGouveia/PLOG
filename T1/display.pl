% Boards and Pieces
initialBoard(
                [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]).
               % [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]).

piecesBlack(List,X):-
        isEmpty(L),temp(L,X,1,List).

piecesWhite(List,X):-
        isEmpty(L),temp(L,X,6,List).

temp(List,NumberOfRepetitions,Piece,New):-
        length(List,L),
        L<(Piece mod 5)*NumberOfRepetitions,
        append(List, [Piece], NewList),
        temp(NewList,NumberOfRepetitions,Piece,New).
        
temp(List,NumberOfRepetitions,Piece,New):-
        length(List,L),
        L=:= (Piece mod 5)*NumberOfRepetitions,
        Piece mod 5 =\= 4,
        NewPiece is Piece+1,
        temp(List,NumberOfRepetitions,NewPiece,New).

temp(List,NumberOfRepetitions,Piece,List):-
        length(List,L),
        L=:= (Piece mod 5)*NumberOfRepetitions,
        Piece mod 5 =:= 4.

% Tradution
piece(0, V) :- V = '*'.
piece(1, V) :- V ='p'.
piece(6, V) :- V ='P'.
piece(2, V) :- V ='c'.
piece(7, V) :- V ='C'.
piece(3, V) :- V ='l'.
piece(8, V) :- V ='L'.
piece(4, V) :- V ='e'.
piece(9, V) :- V ='E'.

player(white , V) :- V = 1.
player(black , V) :- V = 2.



% Display functions 

showBoard(Player, Board, PlayerPieces) :- 
        player(Player,Num),
        write( '\nIt\'s player '),
        write( Num ),
        write( ' turn!\n' ),
        printBoard(Board),
        showPieces(PlayerPieces).

printBoard(Board):-
        write('\n  '),
        length(Board, X),
        printTopBoard(X,0),
        write('\n   ') ,
        printEmptyLine(X),
        printBoard(Board, 1).

printTopBoard(X,X).

printTopBoard(X,Y):-
        X>Y,
        LetterCode is Y+97,
        Y1 is Y+1,
        write('   '),
        char_code(LetterChar,LetterCode),
        write(LetterChar),
        printTopBoard(X,Y1).

printEmptyLine(0):- 
        write('|').

printEmptyLine(X):-
        X>0,
        X1 is X-1,
        write('|---'),
        printEmptyLine(X1).

printBoard([],_):-
        nl,
        nl.

printBoard([H|T],Num):-
        write('\n '),
        write(Num),
        printLine(H),
        length(H,X),
        write('\n   '),
        printEmptyLine(X),
        Num1 is Num+1,
        printBoard(T,Num1).

printLine([]):-
        write(' |').

printLine([H|T]):-
        write(' | '),
        piece(H,Piece),
        write(Piece),
        printLine(T).

% Prints the pieces that are still available

printPieces([],Counter,CurrentPiece):-
        piece(CurrentPiece,Piece),
        write(Counter), write('*'),
        write(Piece), write('('),
        write(CurrentPiece), write(')  ').

printPieces([Code|Pieces],Counter,CurrentPiece):-
        Code==CurrentPiece,
        Counter1 is Counter+1,
        printPieces(Pieces,Counter1,CurrentPiece).

printPieces([Code|Pieces],Counter,CurrentPiece):-
        Code\=CurrentPiece,
        piece(CurrentPiece,Piece),
        write(Counter), write('*'),
        write(Piece), write('('),
        write(CurrentPiece), write(')  '),
        printPieces(Pieces,1,Code).

isEmpty([]).

showPieces(PlayerPieces ):-
        isEmpty(PlayerPieces),
        !,
        write('\n Error: there are no more available pieces :( \n').

showPieces([P|PlayerPieces]):-
        write('\n Player\'s available pieces: \n '),
        printPieces(PlayerPieces,1,P),
        nl.