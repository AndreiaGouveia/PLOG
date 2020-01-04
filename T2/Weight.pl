:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(clpfd)).

%for sublist, first element is position, second element is number of weights
dist(5,[-3,-1,[2,3,-2,-1,1]]).%5 elements
dist(6,[-3,-2,[1,3,[-1,2,-3,1],1],2]).%6 elements
dist(7,[[-3,4,-3,-2,-1,2],[3,2,-2,1],5]).%7 elements
dist(8,[[-1,4,[-1,3,-2,-1,1],2],[1,4,-3,-2,-1,2]]).%8 elements
dist(9,[-3,-2,[-1,5,[-2,2,-2,1],[1,2,-1,3],2],2,4]).%9 elements
dist(10,[[-1,5,[-1,4,[-1,3,-1,1,2],3],2],[1,3,-2,1,2],[2,2,-2,3]]).%10 elements
dist(14,[[-2,3,-2,-1,5],[1,11,[-1,9,[-1,7,-2,-1,[1,5,[-1,3,-2,[1,2,-1,2]],1,2]],1,2],1,3]]).%14
dist(19,[[-2,8,-3,-1,[1,6,[-1,4,-2,-1,[1,2,-1,2]],1,2]],1,[2,10,-3,-1,[1,8,[-1,5,[-3,2,-1,2],-2,-1,1],[1,3,-2,-1,1]]]]).%19
dist(20,[[-4,3,-3,-2,3],[-2,7,-2,-1,[1,5,[-1,3,-1,2,3],1,2]],1,[3,9,[-1,7,[-1,5,-1,[1,2,-2,1],2,3],1,2],1,2]]).%20

weight(X):-dist(X,List),game(X,List,Weights) , display(X,Weights). % X=5,6,10,14,19 or 20
game(Size,Distances,Weights):-

	%Variaveis de restricao
	length(Weights, Size),
    domain(Weights,1,Size),
	%restricao
	all_distinct(Weights),
	%Funcao de avaliacao
	sumWeights(Distances, Weights, 0),
	%Labeling
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

%%%%%%%%%%%%%  Display Section %%%%%%%%%%%%%%%%%%

rmComma([]).
rmComma([H|T]):-
	H == ')',
	!,
	write(H),
	write(','),
	rmComma(T).

rmComma([H|T]):-
	write(H),
	rmComma(T).

getSecondElement([H|T] , T , H).

readSub([H|T], Temp ,NL3):-
	append(Temp , ['[','{',H,','] , NL ),
	getSecondElement(T, NL1 , Elem),
	append(NL , [Elem,'}'] , NL4 ),
	displayResult(NL1, Temp, List),
	append(NL4 , List ,NL2),
	append(NL2 , [']'] , NL3).


displayResult([] , FinalList, FinalList).

displayResult([H|T] , List, FinalList):-
	is_list(H),
	!,
	readSub( H , [] ,Something),
	append(List , Something , List1),
	displayResult(T, List1 , FinalList).

displayResult([H|T] , List, FinalList):-
	append(List, ['(','(',H,')'], List1),
	append(List1,['X', ')'], List2),
	displayResult(T, List2 , FinalList).

conversion(X , R):-
	dist(X,Lista),
	displayResult(Lista , [] ,R).

showResult([] , [] , []).

showResult([H|T] , [H1|T1] , [H1|N]):-
	H == 'X',
	!,
	showResult(T , T1 , N).

showResult([H|T], Result , [H|N]):-
	showResult(T , Result , N).



display(X,R):-
	write('>>Puzzle escolhido:'),
	conversion(X,Lista),
	rmComma(Lista),
	nl,
	write('>>Numero de elementos:'),
	write(X),
	nl,
	write('>>Solucao:'),
	showResult(Lista , R , Final),
	rmComma(Final).

test(X):-
	dist(X,List),game(X,List,R).

getTime(X):-
   statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
   test(X),
   statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
   write('Execution took '), write(ExecutionTime), write(' ms.'), nl.