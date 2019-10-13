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
	getY(Y).
