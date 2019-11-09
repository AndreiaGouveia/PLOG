% === get coords ===
getColumn(Y):-
	repeat,
	write('\n O valor da linha tem de ser entre 1 e 4 \n'),
	read(Y),
	Y=<4,
	Y>=1.

getLine(X):-
	repeat,
	write('\n O valor da coluna tem de ser entre \'a\' e \'d\' \n'),	
	read(X1),
	char_code(X1,X2),
	X2=<100,
	X2>=97,
	X is X2-96.

getCoord(X , Y , Board):-
	getColumn(X),
	getLine(Y),
	validMove(X,Y,Board).


% ===checks if move is valid ===
validMove(0,0,H):-
	H=empty.

validMove(1,0,[H|_]):-
	validMove(0,0,H).

validMove(X,0,[_|T]):-
	X1 is X-1,
	validMove(X1,0,T).

validMove(X,1,[H|_]):-
	validMove(X,0,H).

validMove(X,Y,[_|T]):-
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
	write('\n Choose a piece \n'),% add a show pieces
	read(Piece),
	validPiece(Piece , AvailablePieces , UpdatedPieces).

%===  functions to insert piece in board ===
replace([] , X , Y , Piece , []).

replace([B|Bt] , 1 , Y , Piece, [N|Nt]):-
	replace_column(B, Y , Piece , N),
	replace(Bt , 1 , 6 , Piece , Nt). % ver melhor a questao doo  6

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	X1 is X - 1,
	replace(Bt, X1 , Y , Piece, Nt).

replace_column( [] , X , Piece , []).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) :-
	replace_column(Cs , 1 , Piece , Cs).

replace_column( [C|Cs] , Y , Piece , [C|Ct] ) :- 
  Y1 is Y-1 ,                               
  replace_column( Cs , Y1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces , UpdatedPieces),
	!,
	replace(Board, X , Y, Piece, NewBoard).

getPlay(Board, Player , NewBoard , UpdatedPieces):-
	write("\n Invalid Play\n").
