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


% ===checks if move is valid ===
validMove(0,0,H):-
	H=empty, !.

validMove(1,0,[H|_]):-
	validMove(0,0,H).

validMove(X,0,[_|T]):-
	X>1,
	X1 is X-1,
	validMove(X1,0,T).

validMove(X,1,[H|_]):-
	validMove(X,0,H).

validMove(X,Y,[_|T]):-
	Y>1,
	Y1 is Y-1,
	validMove(X,Y1,T).

% === checks if piece is valid 
validPiece(Piece, [] , []):-
	Piece = 0.

validPiece(Piece, [Piece|T] , N):-
	validPiece(0, T , N).

validPiece(Piece, [H|T] , [H|N]):-
	validPiece(Piece , T , N).

% === ask for piece ===
getPiece(Piece , AvailablePieces , UpdatedPieces):-
	repeat,
	showPieces(AvailablePieces),
	write('\n Choose a piece (INT)\n'),
	read(Piece),
	validPiece(Piece , AvailablePieces , UpdatedPieces).

%===  functions to insert piece in board ===
replace([] , X , Y , Piece , []).

replace([B|Bt] , X , 1 , Piece, [N|Nt]):-
	replace_column(B, X , Piece , N),
	replace(Bt , 6 , 1 , Piece , Nt). % ver melhor a questao doo  6

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	Y1 is Y - 1,
	replace(Bt, X , Y1 , Piece, Nt).

replace_column( [] , X , Piece , []).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) :-
	replace_column(Cs , 1 , Piece , Cs).

replace_column( [C|Cs] , X , Piece , [C|Ct] ) :- 
  X1 is X-1 ,                               
  replace_column( Cs , X1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces , UpdatedPieces),
	!,
	replace(Board, X , Y, Piece, NewBoard).

getPlay(Board, Player , NewBoard , UpdatedPieces):-
	write("\n Invalid Play\n").
