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

% === Checks if piece is valid ===

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
% TO DO

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
validPiece(Piece, [Piece|_]).

validPiece(Piece, [_|T]):-
	validPiece(Piece , T).

% === removes piece from available pieces === 
removePiece(_Piece, [] , []).

removePiece(Piece, [Piece|T] , N):-
	removePiece(0, T , N).

removePiece(Piece, [H|T] , [H|N]):-
	removePiece(Piece , T , N).

% === ask for piece ===
getPiece(Piece , AvailablePieces):-
	repeat,
	showPieces(AvailablePieces),
	write('\n Choose a piece (INT)\n'),
	read(Piece),
	validPiece(Piece , AvailablePieces ).

%===  functions to insert piece in board ===
replace([] , _X , _Y , _Piece , []).

replace([B|Bt] , X , 1 , Piece, [N|Nt]):-
	replace_column(B, X , Piece , N),
	replace(Bt , 6 , 1 , Piece , Nt). % ver melhor a questao doo  6 //TODO nao podes so fazer ponto final na linha anterior?

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	Y1 is Y - 1,
	replace(Bt, X , Y1 , Piece, Nt).

replace_column( [] , _X , _Piece , []).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) :-
	replace_column(Cs , 1 , Piece , Cs).

replace_column( [C|Cs] , X , Piece , [C|Ct] ) :- 
  X1 is X-1 ,                               
  replace_column( Cs , X1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, _Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces),
	pieceCheck(Board , Y , Piece),
	!,
	removePiece(Piece , AvailablePieces , UpdatedPieces),
	replace(Board, X , Y, Piece, NewBoard),
	checkWin(NewBoard , X , Y , Piece ).

getPlay(_Board, _Player , _NewBoard , _AvailablePieces , _UpdatedPieces):-
	write("\n Invalid Play\n").

% === function that checks if player has won ===

checkWin(Board , X , Y , Piece ):-
	winRow(Board , Counter , Y , Piece), %Counter?
	write('\n You won! \n').

checkWin(_Board , _X , _Y , _Piece ):-
	write('\n Keep playing! \n').