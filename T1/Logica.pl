getX(X):-
	repeat,
	write('O valor de X tem de ser entre 1 e 4\n'),
	read(X),
	X=<4,
	X>=1.

getY(Y):-
	repeat,
	write('O valor de Y tem de ser entre 1 e 4\n'),
	read(Y),
	Y=<4,
	Y>=1.

getCoord(X,Y):-
	getX(X),
	getY(Y),
	initialBoard(Board),%must find way to use global board
	validMove(X,Y,Board).

validMove(0,0,H):-
	H=='empty'.

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
