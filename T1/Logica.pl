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
	repeat,
	getColumn(X),
	getLine(Y),
	validMove(X , Y,Board).

% ============= 
% === RULES ===
% =============

% === Win from row ===

winRowR([] , Counter , Counter).

winRowR( [H|T] , Counter ,FinalNumber):-
	Value1 is H mod 5,
	Counter1 is Counter * Value1,
	winRowR( T , Counter1 , FinalNumber).

winRow( _ , 24 , -1).

winRow( [H|T] , FinalNumber , 1):-
	winRowR(H , 1 , FinalNumber),
	FinalNumber == 24,
	!,
	winRow( T , 24 , -1).

winRow( [_|T], FinalNumber , X):-
	X>0,
	X1 is X-1,
	winRow( T , FinalNumber , X1).


% === Win from column ===
winColumnR([] , Counter , Counter).

winColumnR( [H|T] , Counter ,FinalNumber):-
	Value1 is H mod 5,
	Counter1 is Counter * Value1,
	winColumnR( T , Counter1 , FinalNumber).

winColumn( _N , 24 , -1).

winColumn( [H|T] , FinalNumber , 1 ):-
	winColumnR(H , 1 , FinalNumber),
	FinalNumber == 24,
	!,
	winColumn( T , 24 , -1).

winColumn( [_H|T], FinalNumber , Y):-
	Y>0,
	Y1 is Y-1,
	winColumn( T , FinalNumber , Y1).

% === Win from square ===

% === checks if move is valid ===

searchRow( 1 , [H|_]):-
	H==0,!.

searchRow( Y , [_|T]):-
	Y>1,
	Y1 is Y - 1,
	searchRow(Y1 , T).

searchColumn(1 , Y , [H|_]):-
	searchRow( Y , H).

searchColumn(X , Y , [_|T]):-
	X>1,
	X1 is X - 1,
	searchColumn( X1 , Y , T).

validMove(X , Y , List):-
	searchColumn(X , Y , List).
	

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
	write('\n Choose a piece \n'),
	read(Piece),
	validPiece(Piece , AvailablePieces , UpdatedPieces).

%===  functions to insert piece in board ===
replace([] , _X , _Y , _Piece , []).

replace([B|Bt] , 1 , Y , Piece, [N|Nt]):-
	replace_column(B, Y , Piece , N),
	replace(Bt , 1 , 6 , Piece , Nt). % ver melhor a questao doo  6

replace([B|Bt] , X, Y , Piece , [B|Nt]):-
	X1 is X - 1,
	replace(Bt, X1 , Y , Piece, Nt).

replace_column( [] , _X , _Piece , []).

replace_column( [_|Cs] , 1 , Piece , [Piece|Cs] ) :-
	replace_column(Cs , 1 , Piece , Cs).

replace_column( [C|Cs] , Y , Piece , [C|Ct] ) :- 
  Y1 is Y-1 ,                               
  replace_column( Cs , Y1 , Piece , Ct ).                                          


% === function that gets the play ===
getPlay(Board, _Player , NewBoard , AvailablePieces , UpdatedPieces):-
	getCoord(X , Y , Board),
	getPiece(Piece , AvailablePieces , UpdatedPieces),
	!,
	replace(Board, X , Y, Piece, NewBoard),
	checkWin(NewBoard , X , Y).

getPlay(_Board, _Player , _NewBoard ,AvailablePieces, _UpdatedPieces):-
	write("\n Invalid Play\n").

checkWin(Board , X , Y):-
	winRow(Board , Counter , X),
	!,
	write('\n You won! \n').

checkWin(Board , X , Y):-
	write('\n Not yet! \n').