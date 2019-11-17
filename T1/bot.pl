:- use_module(library(lists)).

% === obtenção das jogadas validas ===

printL([]).%//TODO TEMP
printL([H|T]):-
    write(H),nl,printL(T).

valid_moves(_Board, ListOfMoves, Pieces , FinalList):-
    isEmpty(Pieces),
    printL(ListOfMoves),
    copy(ListOfMoves,FinalList).

valid_moves(Board, ListOfMoves, [Piece|T] , FinalList):-
    findall(V-X-Y-Piece, (pieceRuleValidation(Board , X , Y , Piece),finishMove(Board , X , Y , Piece , [Piece|T] , _NewPieces , NewBoard),value(NewBoard , V)), List),
    append(ListOfMoves, List, NewList),
    valid_moves(Board , NewList , T , FinalList).

% == getBest Value
getfirstelement([H|_T], H).
getValue(V-_X-_Y-_Piece , V).

bestMove([] , Move, Move).

bestMove([H|T], Move, BestMove):-
    getValue(H ,Value),
    getValue(Move , Value2),
    Value > Value2, % if new move is better than the last
    !,
    bestMove(T , H, BestMove).

bestMove([_H|T] , Move, BestMove):-
    bestMove(T , Move, BestMove).

getBestMove(List , Move, BestMove):-
    getfirstelement(List, Move),
    bestMove(List , Move, BestMove).

% === get move
getMove(_V-X-Y-Piece, X , Y, Piece).


%     RANDOM
choose_move(_Board , 0 , _X , _Y , _Piece, []):-
    write('\n ---- No available moves ----').

choose_move(Board , 0 , X , Y, Piece, ListOfMoves):-
    random_select(Elem,ListOfMoves,_),
    getMove(Elem , X , Y , Piece),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

%       WITH VALUE
choose_move(_Board , 1 , _X , _Y, _Piece, []):-
    write('\n ---- No available moves ----').

choose_move(Board , 1 , X , Y, Piece, List):-
    getBestMove( List , _Move, BestMove),
    getMove(BestMove , X , Y , Piece),
    validMove(X , Y , Board),
    !,
    write('\nx: '),
    write(X),
    write('\ny: '),
    write(Y).

choose_move(Board , UseValue , X , Y, Piece, [_H|T]):-
    choose_move(Board , UseValue , X , Y, Piece, T).


% ==== VALUE FUNCTIONS ===
list_sum([], 0).
list_sum([Head | Tail], TotalSum) :-
    list_sum(Tail, Sum1),
    Count1 is Head mod 5,
    TotalSum is Count1 + Sum1.


copy(L,R) :- append(L,[],R). % function to copy lists

are_identical(X, Y) :- % sees if 2 elements are identical
    X == Y.

filterList(Elem, List, Number) :- % sees how many 0s
    exclude(are_identical(Elem), List, FilteredList),
    length(FilteredList , Number).
   /* write('\nLength: '),
    write(Number).*/

atributeValue(_Line, 15 , 4):- !. % if row if full - best option
atributeValue(_Line, 5 , 1):- !. % missing 3 piece - middle option

atributeValue(Line, 6 , 2):- % missing 2 pieces - middle option
    list_sum(Line , Sum),
    /*write('\nSum2: '),
    write(Sum),*/
    member(Sum , [3,4,5,6,7]), % if not, play is not smart
    !.

atributeValue(Line, 1 , 3):- % missing 1 pieces - worst option
    list_sum(Line , Sum),
    /*write('\nSum3: '),
    write(Sum),*/
    member(Sum , [6,7,8,9]), % if not, play is not smart
    !.
atributeValue(_Line, 5 , 0):- !. % if row is isEmpty

atributeValue(_Line , 0 , _Counter). % if anything else

checkLine(Line , Value):-
    filterList(0 , Line , ZeroCounter),
    atributeValue( Line , Value , ZeroCounter).

checkLines([] , Counter , Counter).

checkLines([H|T] , Counter , FinalValue):-
    checkLine(H , Value1),
    atributeBigger(Value1, Counter, Result),
    % write('alive'),
    checkLines(T , Result , FinalValue).

value(Board , Value):-
    %lines
    checkLines(Board , 0 , Counter),
    %rows
    transpose(Board , TransposedBoard),
    checkLines(TransposedBoard , 0 , Counter1),
    atributeBigger(Counter , Counter1 , Value1),
    %squares
    getSquare(Board,1,1,List1),
    getSquare(Board,4,4,List2),
    getSquare(Board,2,3,List3),
    getSquare(Board,3,2,List4),
    checkLines([List1,List2,List3,List4] , 0 , Counter2),
    atributeBigger(Value1 , Counter2 , Value).

atributeBigger(Rows , Colums , Rows):-
    Rows>=Colums,
    !.

atributeBigger(Rows , Colums , Colums):-
    Colums >= Rows.

    
