:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(clpfd)).

%for sublist, first element is position, second element is number of weights
dist(5,[-3,-1,[2,3,-2,-1,1]]).%5 elements
dist(6,[-3,-2,[1,3,[-1,2,-3,1],1],2]).%6 elements
dist(10,[[-1,5,[-1,4,[-1,3,-1,1,2],3],2],[1,3,-2,1,2],[2,2,-2,3]]).%10 elements
dist(14,[[-2,3,-2,-1,5],[1,11,[-1,9,[-1,7,-2,-1,[1,5,[-1,3,-2,[1,2,-1,2]],1,2]],1,2],1,3]]).%14
dist(20,[[-4,3,-3,-2,3],[-2,7,-2,-1,[1,5,[-1,3,-1,2,3],1,2]],1,[3,9,[-1,7,[-1,5,-1,[1,2,-2,1],2,3],1,2],1,2]]).%20

test(X,R):-dist(X,List),game(X,List,R). % X=5,6,10,14 or 20
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