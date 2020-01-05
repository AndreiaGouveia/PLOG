:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(clpfd)).

%for sublist, first element is position, second element is number of weights
dist(3,[-2,-1,7]).
dist(5,[-3,-1,[2,3,-2,-1,1]]).%5 elements
dist(6,[-3,-2,[1,3,[-1,2,-3,1],1],2]).%6 elements
dist(7,[[-3,4,-3,-2,-1,2],[3,2,-2,1],5]).%7 elements
dist(8,[[-1,4,[-1,3,-2,-1,1],2],[1,4,-3,-2,-1,2]]).%8 elements
dist(9,[-3,-2,[-1,5,[-2,2,-2,1],[1,2,-1,3],2],2,4]).%9 elements
dist(10,[[-1,5,[-1,4,[-1,3,-1,1,2],3],2],[1,3,-2,1,2],[2,2,-2,3]]).%10 elements
dist(14,[[-2,3,-2,-1,5],[1,11,[-1,9,[-1,7,-2,-1,[1,5,[-1,3,-2,[1,2,-1,2]],1,2]],1,2],1,3]]).%14
dist(19,[[-2,8,-3,-1,[1,6,[-1,4,-2,-1,[1,2,-1,2]],1,2]],1,[2,10,-3,-1,[1,8,[-1,5,[-3,2,-1,2],-2,-1,1],[1,3,-2,-1,1]]]]).%19
dist(20,[[-4,3,-3,-2,3],[-2,7,-2,-1,[1,5,[-1,3,-1,2,3],1,2]],1,[3,9,[-1,7,[-1,5,-1,[1,2,-2,1],2,3],1,2],1,2]]).%20


weight(X):-dist(X,List),game(X,List,R),
write('Distances: '),write(List),nl,write('Weights: '),write(R),nl,display(List,R,[],[]). % X=5,6,10,14,19 or 20
game(Size,Distances,Weights):-
	length(Weights, Size),
    domain(Weights,1,Size),
	all_distinct(Weights),
	sumWeights(Distances, Weights, 0),
    labeling([], Weights).

sumWeights([],[],0).

sumWeights([[Position,NumWeights|ListDistAux]|Distances],Weights,Acumulator):-%if first element of Distances is list
	first_n(NumWeights,Weights,FirstWeights),
	sumWeights(ListDistAux,FirstWeights,0),
	append(FirstWeights, RestWeights, Weights),
	multiply(Position,FirstWeights,Total),
	sumWeights(Distances,RestWeights,AuxAcumulator),
	Acumulator #= Total + AuxAcumulator.

sumWeights([H1|Distances],[H2|Weights],Acumulator):-%if H1 is not list
	\+ is_list(H1),
	sumWeights(Distances,Weights,AuxAcumulator),
	Acumulator #= H1 * H2 + AuxAcumulator.

%first_n(0,_,[]).
%first_n(N, [H|T], [H|T1]) :- N > 0, N1 is N-1, first_n(N1, T, T1).
first_n(N, List, AuxList) :-
	length(AuxList,N),
	append(AuxList, _, List).
	

multiply(_,[],0).

multiply(Dist,[H|Weights],Total):-
	multiply(Dist,Weights,AuxTotal),
	Total #= AuxTotal + Dist * H.


%display

isEmpty([]).

printSum([T]):- write(T).
printSum([H|T]):-
	write(H), write(' + '), printSum(T).


display( [[H1,H2|H3]|H] ,P,Aux1,Aux2):-
	\+isEmpty(H),
	first_n(H2, P, AuxList),
	append(AuxList, RestP, P),
	append(Aux2, [AuxList], NewAux2),
	append(Aux1, [H3], NewAux1),
	write(H1),write(' * ('),printSum(AuxList),write(') + '),display(H,RestP,NewAux1,NewAux2).

display( [[H1,H2|H3]|H] ,P,Aux1,Aux2):-
	isEmpty(H),
	first_n(H2, P, AuxList),
	append(AuxList, [], P),
	append(Aux2, [AuxList], NewAux2),
	append(Aux1, [H3], NewAux1),
	write(H1),write(' * ('),printSum(AuxList),write(') = 0'),nl,display2(NewAux1,NewAux2).
	
display([H1|H2],[P1|P2],Aux,Aux2):-
	\+isEmpty(H2),
	write(H1),write(' * '),write(P1),write(' + '),
	display(H2,P2,Aux,Aux2).

display([H1],[P1],Aux1,Aux2):-
	write(H1),write(' * '),write(P1),write(' = 0'),nl,display2(Aux1,Aux2).

display2([],[]).

display2([Aux1|T],[Aux2|T1]):-
	display(Aux1,Aux2,T,T1).
% time tests

test(X):-
	dist(X,List),game(X,List,R).

getTime(X):-
   statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
   test(X),
   statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
   write('Execution took '), write(ExecutionTime), write(' ms.'), nl.
