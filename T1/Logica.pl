% === get coords ===
getLine(Y,Size):-
	write('\n Line value must be between 1 and '),
	write(Size),
	nl,
	read_line([H|T]),
    length(T,0),
	Y is H-48,
	Y=<Size,
	Y>=1.

getColumn(X,Size):-
	MaxCharCode is 96+Size,
	char_code(Char,MaxCharCode),
	write('\n Column value must be between \'a\' and \''),
	write(Char),
	write('\' (uppercase is also accepted)\n'),	
	read_line([H|T]),
	length(T,0),
	auxGetColumn(H,X,MaxCharCode).

auxGetColumn(H,X,MaxCharCode):- %para minuscula
	H=<MaxCharCode,
	H>=97,
	X is H-96.

auxGetColumn(H,X,MaxCharCode):- %para maiuscula
	H=<MaxCharCode-22,
	H>=65,
	X is H-64.

getCoord(X , Y , Board):-
	length(Board, Size),
	repeat,
	getLine(Y,Size),
	getColumn(X,Size),
	validMove(X,Y,Board).

% ============= 
% === RULES ===
% =============

% === Win from List ===
	
winList([] , 24).

winList( [H|T] , Counter):-
	Value1 is H mod 5,
	Counter1 is Counter * Value1,
	winList( T , Counter1).

/* nth1( [H|_] , 1 , H).

nth1( [_|T], Y , Row):-
	Y>0,
	Y1 is Y-1,
	nth1( T , Y1 , Row). */

% === Checks if piece is valid in row===

	pieceCheckR(Board , Y , Piece):-
		Piece>5,
		Piece1 is Piece-5,
		pieceCheckRAux(Board,Y,Piece1).

	pieceCheckR(Board , Y , Piece):-
		Piece<5,
		Piece1 is Piece+5,
		pieceCheckRAux(Board,Y,Piece1).

	pieceCheckRAux(Board, Y, Piece):-
		nth1(Y,Board,Row),
		\+member(Piece, Row).


/*
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
	pieceCheck( T , Y1 , Piece).*/



% === Win from column ===
/*
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
*/
% === Checks if piece is valid in column ===

pieceCheckC(Board , X , Piece):-
	Piece>5,
	Piece1 is Piece-5,
	pieceCheckCAux(Board,X,Piece1).

pieceCheckC(Board , X , Piece):-
	Piece<5,
	Piece1 is Piece+5,
	pieceCheckCAux(Board,X,Piece1).

pieceCheckCAux(Board, X, Piece):-
	transpose(Board,Board1),
	nth1(X,Board1,Column),
	\+member(Piece, Column).

/*
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
*/
% === Win from square ===

getSquare(Board,X,Y,[Value1,Value2,Value3,Value4]):-
	X1 is X + (X mod 2) - 1,
	Y1 is Y + (Y mod 2) - 1,
	Y2 is Y1+1,
	X2 is X1+1,
	nth1(Y1,Board,Row),
	nth1(Y2,Board,Row1),
	nth1(X1,Row,Value1),
	nth1(X2,Row,Value2),
	nth1(X1,Row1,Value3),
	nth1(X2,Row1,Value4).

pieceCheckS(List , Piece):-
	Piece>5,
	Piece1 is Piece-5,
	\+member(Piece1, List).

pieceCheckS(List , Piece):-
	Piece<5,
	Piece1 is Piece+5,
	\+member(Piece1, List).

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
	read_line([H|T]),
	length(T,0),
	Piece is H-48,
	validPiece(Piece , AvailablePieces ).

%===  functions to insert piece in board ===

replace([B|Bt] , X , 1 , Piece, [N|Bt]):-
	replace_column(B, X , Piece , N).

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	Y1 is Y - 1,
	replace(Bt, X , Y1 , Piece, Nt).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) .

replace_column( [C|Cs] , X , Piece , [C|Ct] ) :- 
  X1 is X-1 ,                               
  replace_column( Cs , X1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, _Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces),
	pieceCheckR(Board , Y , Piece),
	pieceCheckC(Board , X , Piece),
	getSquare(Board,X,Y,List),
	pieceCheckS(List, Piece),
	!,
	removePiece(Piece , AvailablePieces , UpdatedPieces),
	replace(Board, X , Y, Piece, NewBoard),
	checkWin(NewBoard , X , Y ).

getPlay(_Board, _Player , _NewBoard , _AvailablePieces , _UpdatedPieces):-
	write("\n Invalid Play\n").

% === function that checks if player has won === 

checkWin(Board , _X , Y ):- % win from row
	nth1(Y,Board,Row),
	winList(Row, 1),
	!,
	write('\n You won! \n').

checkWin(Board , X , _Y ):- % win from column
	transpose(Board, Board1),
	nth1(X,Board1,Row),
	winList(Row, 1),
	!,
	write('\n You won! \n').

checkWin(Board , X , Y ):- % win from square
	getSquare(Board,X,Y,List),
	winList(List, 1),
	!,
	write('\n You won! \n').

checkWin(_Board , _X , _Y ):-
	write('\n Keep playing! \n').