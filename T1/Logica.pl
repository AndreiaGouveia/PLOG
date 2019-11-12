% === get coords ===
getLine(Y,Size):-
	write('\n Line value must be between 1 and '),
	write(Size),
	nl,
	read(Y),
	Y=<Size,
	Y>=1.

getColumn(X,Size):-
	MaxCharCode is 96+Size,
	char_code(Char,MaxCharCode),
	write('\n Column value must be between \'a\' and \''),
	write(Char),
	write('\' \n'),	
	read(X1),
	char_code(X1,X2),
	X2=<MaxCharCode,
	X2>=97,
	X is X2-96.

getCoord(X , Y , Board):-
	length(Board, Size),
	repeat,
	getLine(Y,Size),
	getColumn(X,Size),
	validMove(X,Y,Board).

% ============= 
% === RULES ===
% =============

% === Win from row ===
	
winRowR([] , Counter , Counter , _Piece).

winRowR( [H|T] , Counter , FinalNumber , Piece):-
	Value1 is H mod 5,
	Counter1 is Counter * Value1,
	winRowR( T , Counter1 , FinalNumber , Piece).

winRow( _ , 24 , -1 , _Piece).

winRow( [H|T] , FinalNumber , 1 , Piece):-
	winRowR(H , 1 , FinalNumber, Piece),
	FinalNumber == 24,
	!,
	winRow( T , 24 , -1 , Piece).

winRow( [_|T], FinalNumber , X , Piece ):-
	X>0,
	X1 is X-1,
	winRow( T , FinalNumber , X1 , Piece).

% === Checks if piece is valid in row===

pieceCheckR([], _Piece).

pieceCheckR( [H|T] , Piece):-
	H\=Piece,
	Piece1 is Piece mod 5,
	Value1 is H mod 5,
	Value1\=Piece1,
	pieceCheckR( T , Piece).

pieceCheckR( [H|T] , Piece):-
	H==Piece,
	pieceCheckR( T , Piece).

pieceCheck( [H|_] , 1 , Piece):-
	pieceCheckR(H , Piece).

pieceCheck( [_|T], Y , Piece ):-
	Y>1,
	Y1 is Y-1,
	pieceCheck( T , Y1 , Piece).

% === Win from column ===

winColumnR([H|_T] , H , 1):-!.

winColumnR([_H|T] , Counter , Y):-
	Y>1,
	Y1 is Y - 1 ,
	winColumnR(T, Counter , Y1).

winColumn([] , 24 , _Y).

winColumn([H|T] , FinalNumber , Y ):- 
	winColumnR(H , Counter , Y),
	Value is Counter mod 5,
	Counter1 is FinalNumber * Value,
	winColumn(T , Counter1 , Y).

% === Checks if piece is valid in column ===

checkPieceColumnR([H|_T] , H , 1):-!.

checkPieceColumnR([_H|T] , Counter , Y):-
	Y>1,
	Y1 is Y - 1 ,
	checkPieceColumnR(T, Counter , Y1).

checkPieceColumn([] , _Y , _Piece).

checkPieceColumn([H|T] , Y , Piece):- 
	checkPieceColumnR(H , Counter , Y),
	Piece\=	Counter, 
	Value is Counter mod 5,
	Piece\=Value,
	Value1 is Piece mod 5,
	Value1\=Value,
	checkPieceColumn(T , Y , Piece).

checkPieceColumn([H|T] , Y , Piece):- 
	checkPieceColumnR(H , Counter , Y),
	Piece==Counter, 
	checkPieceColumn(T , Y , Piece).
% === Win from square ===
% TO DO

% === checks if move is valid ===

validMove( 1 , [H|_]):-
	H==0,!.

validMove( X , [_|T]):-
	X>1,
	X1 is X - 1,
	validMove(X1 , T).

validMove(X , 1 , [H|_]):-
	validMove( X , H).

validMove(X , Y , [_|T]):-
	Y>1,
	Y1 is Y - 1,
	validMove( X , Y1 , T).	

% === checks if piece is valid 
validPiece(Piece, [Piece|_T]).

validPiece(Piece, [_H|T]):-
	validPiece(Piece , T).

% === removes piece from available pieces === 
removePiece(_Piece, [] , []).

removePiece(Piece, [Piece|T] , N):-
	removePiece(0, T , N).

removePiece(Piece, [H|T] , [H|N]):-
	removePiece(Piece , T , N).

% === ask for piece ===
getPiece(Piece , AvailablePieces):-
	showPieces(AvailablePieces),
	write('\n Choose a piece (INT)\n'),
	read(Piece),
	validPiece(Piece , AvailablePieces ).

%===  functions to insert piece in board ===

replace([B|Bt] , X , 1 , Piece, [N|Bt]):-
	replace_column(B, X , Piece , N).

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	Y1 is Y - 1,
	replace(Bt, X , Y1 , Piece, Nt).

replace_column( [] , _X , _Piece , []).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) .

replace_column( [C|Cs] , X , Piece , [C|Ct] ) :- 
  X1 is X-1 ,                               
  replace_column( Cs , X1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, _Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces),
	pieceCheck(Board , Y , Piece),
	checkPieceColumn(Board , X , Piece),
	!,
	removePiece(Piece , AvailablePieces , UpdatedPieces),
	replace(Board, X , Y, Piece, NewBoard),
	checkWin(NewBoard , X , Y , Piece ).

getPlay(_Board, _Player , _NewBoard , _AvailablePieces , _UpdatedPieces):-
	write("\n Invalid Play\n").

% === function that checks if player has won ===

checkWin(Board , _X , Y , Piece ):-
	winRow(Board , _Counter , Y , Piece),
	!,
	write('\n You won! \n').

checkWin(Board , X , _Y , _Piece ):-
	winColumn(Board , 1 , X ),
	!,
	write('\n You won! \n').


checkWin(_Board , _X , _Y , _Piece ):-
	write('\n Keep playing! \n').