:- use_module(library(lists)).

% === obtenção das jogadas validas ===
isEmptyMoves([]).
/*
selectPiece([H|_], H , 1).

selectPiece([_H|T], Piece , Counter):-
    Counter1 is Counter - 1,
    selectPiece(T , Piece , Counter1).*/

valid_moves(Board, ListOfMoves, AvailablePieces , Piece ,Counter):-
    %Counter1 is Counter,
    %selectPiece(AvailablePieces , Piece , Counter1),
    nth1(Counter,AvailablePieces,Piece),
    findall(X-Y, pieceRuleValidation(Board , X , Y , Piece), ListOfMoves),
    isEmptyMoves(ListOfMoves),
    !,
    Counter1 is Counter + 1,
    valid_moves(Board , ListOfMoves , AvailablePieces , Piece , Counter1).

valid_moves(Board, ListOfMoves, AvailablePieces , Piece , Counter):-
    %selectPiece(AvailablePieces , Piece , Counter),
    nth1(Counter,AvailablePieces,Piece),
    findall(X-Y, pieceRuleValidation(Board , X , Y , Piece), ListOfMoves),
    write('\nList of moves: '),
    write(ListOfMoves),
    nl.

getMove(X-Y, X , Y).

choose_move(_Board , 0 , _X , _Y , []):-
    write('\n ---- No available moves ----').

choose_move(Board , 0 , X , Y , [H|_T]):-
    getMove(H , X , Y),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

choose_move(Board , 0 , X , Y , [_H|T]):-
    choose_move(Board , 0 , X , Y , T).
    

choose_move(Board , 0 , X , Y , [H|T]):- 
    value(Board , Piece , X , Y , 0).


% ==== VALUE FUNCTIONS ===
% == sumList(Line, Counter1),

are_identical(X, Y) :-
    X == Y.

filterList(Elem, List, Number) :-
    exclude(are_identical(Elem), List, FilteredList),
    length(FilteredList , Number).

checkLine(Line , Value , ZeroCounter):-
    filterList(0 , Line , ZeroCounter),
    checkLines ( Line , Value , ZeroCounter).

checkLines(Line, 0 , 0).

checkLines(Line, 10 , 1).

checkLines(Line, Value , 2).

checkLines(Line, Value , 3).

checkLines([H|T] , Counter):-
    checkLine(H , Value1),
    Counter1 is Counter + Value1,
    checkLines(T , Counter1).

checkLines([H|T] , Counter):-
    checkLines(T , Counter).

value(NewBoard , Value):-
    checkLines(NewBoard , Counter),
    write('\nVALUE ROWS : '),
    write(Counter),
    transpose(NewBoard , TransposedBoard),
    checkLine(TransposedBoard , Counter1),
    write('\nVALUE COLUMS : '),
    write(Counter1),
    atributeBigger(Counter , Counter1 , Value),
    write('\nFINAL VALUE : '),
    write(Counter).

atributeBigger(Rows , Colums , Rows):-
    Rows>=Colums,
    !.

atributeBigger(Rows , Colums , Colums):-
    Colums >= Rows.

    
