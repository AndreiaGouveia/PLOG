% === obtenção das jogadas validas ===
isEmptyMoves([]).

selectPiece([H|_], H , 1).

selectPiece([H|T], Piece , Counter):-
    Counter1 is Counter - 1,
    selectPiece(T , Piece , Counter1).

valid_moves(Board, ListOfMoves, AvailablePieces , Piece ,Counter):-
    Counter1 is Counter,
    selectPiece(AvailablePieces , Piece , Counter1),
    findall(X-Y, pieceRuleValidation(Board , X , Y , Piece), ListOfMoves),
    isEmptyMoves(ListOfMoves),
    !,
    Counter2 is Counter1 + 1,
    valid_moves(Board , ListOfMoves , AvailablePieces , Piece , Counter2).

valid_moves(Board, ListOfMoves, AvailablePieces , Piece , Counter):-
    selectPiece(AvailablePieces , Piece , Counter),
    findall(X-Y, pieceRuleValidation(Board , X , Y , Piece), ListOfMoves),
    write('\nList of moves: '),
    write(ListOfMoves),
    nl.

getMove(X-Y, X , Y).

choose_move(Board , 0 , X , Y , []):-
    write('\n ---- No available moves ----').

choose_move(Board , 0 , X , Y , [H|T]):-
    getMove(H , X , Y),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

choose_move(Board , 0 , X , Y , [H|T]):-
    choose_move(Board , 0 , X , Y , T).
    

