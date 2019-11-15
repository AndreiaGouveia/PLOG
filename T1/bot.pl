:- use_module(library(lists)).

% === obtenção das jogadas validas ===
isEmptyMoves([]).

valid_moves(Board, ListOfMoves, AvailablePieces , Piece ,Counter):-
    nth1(Counter,AvailablePieces,Piece),
    findall(V-X-Y, (pieceRuleValidation(Board , X , Y , Piece),value(Board , V)), ListOfMoves),
    isEmptyMoves(ListOfMoves),
    !,
    Counter1 is Counter + 1,
    valid_moves(Board , ListOfMoves , AvailablePieces , Piece , Counter1).

valid_moves(Board, ListOfMoves, AvailablePieces , Piece , Counter):-
    nth1(Counter,AvailablePieces,Piece),
    findall(V-X-Y, (pieceRuleValidation(Board , X , Y , Piece),value(Board , V)), ListOfMoves),
    write('\nList of moves: '),
    write(ListOfMoves),
    nl.

% == getBest Value
getfirstelement([H|T], H).
getValue(V-X-Y , V).

bestMove([] , Move).

bestMove([H|T], Move ):-
    getValue(H ,Value),
    getValue(Move , Value2),
    Value > Value2, % if new move is better than the last
    !,
    bestMove(T , H).

bestMove([H|T] , Move):-
    bestMove(T , Move).

getBestMove(List , Move):-
    getfirstelement(List, Move),
    bestMove(List , Move).

% === get move
getMove(V-X-Y, X , Y).


%     RANDOM
choose_move(_Board , 0 , _X , _Y , _Value, []):-
    write('\n ---- No available moves ----').

choose_move(Board , 0 , X , Y , Value , [H|T]):-
    getMove(H , X , Y ),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

choose_move(Board , 0 , X , Y , Value, [_H|T]):-
    choose_move(Board , 0 , X , Y , Value, T).


%       WITH VALUE
choose_move(_Board , 1 , _X , _Y , _Value, []):-
    write('\n ---- No available moves ----').

choose_move(Board , 1 , X , Y , Value , List):-
    getBestMove( List , Move),
    getMove(Move , X , Y ),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

choose_move(Board , 1 , X , Y , Value, [_H|T]):-
    choose_move(Board , 1 , X , Y , Value, T).


% ==== VALUE FUNCTIONS ===
list_sum([], 0).
list_sum([Head | Tail], TotalSum) :-
    list_sum(Tail, Sum1),
    Count1 is Head mod 5,
    TotalSum is Count1 + Sum1.


copy(L,R) :- accCp(L,R). % function to copy lists
accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).

are_identical(X, Y) :- % sees if 2 elements are identical
    X == Y.

filterList(Elem, List, Number) :- % sees how many 0s
    exclude(are_identical(Elem), List, FilteredList),
    length(FilteredList , Number).
   /* write('\nLength: '),
    write(Number).*/

atributeValue(_Line, 0 , 4):- !. % if row if full
atributeValue(_Line, 5 , 1):- !. % missing 3 piece - middle option

atributeValue(Line, 1 , 2):- % missing 2 pieces - worst option
    list_sum(Line , Sum),
    /*write('\nSum2: '),
    write(Sum),*/
    member(Sum , [3,4,5,6,7]), % if not, play is not smart
    !.

atributeValue(Line, 10 , 3):- % missing 1 pieces - best option
    list_sum(Line , Sum),
    /*write('\nSum3: '),
    write(Sum),*/
    member(Sum , [6,7,8,9]), % if not, play is not smart
    !.
atributeValue(_Line, 5 , 0):- !. % if row is isEmpty

atributeValue(Line , 0 , Counter). % if anything else

checkLine(Line , Value):-
    copy(Line, TempList),
    filterList(0 , TempList , ZeroCounter),
    atributeValue( Line , Value , ZeroCounter).

checkLines([] , Counter , Counter).

checkLines([H|T] , Counter , FinalValue):-
    checkLine(H , Value1),
    atributeBigger(Value1, Counter, Result),
    % write('alive'),
    checkLines(T , Result , FinalValue).

value(NewBoard , Value):-
    checkLines(NewBoard , 0 , Counter),
    /*write('\nVALUE ROWS : '),
    write(Counter),*/
    transpose(NewBoard , TransposedBoard),
    checkLines(TransposedBoard , 0 , Counter1),
    /*write('\nVALUE COLUMS : '),
    write(Counter1),*/
    atributeBigger(Counter , Counter1 , Value).
   /* write('\nFINAL VALUE : '),
    write(Counter).*/

atributeBigger(Rows , Colums , Rows):-
    Rows>=Colums,
    !.

atributeBigger(Rows , Colums , Colums):-
    Colums >= Rows.

    
