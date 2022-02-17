dim(4,4).
start([1,0]).
end([2,2]).
bomb([0,1]).
bomb([1,2]).
bomb([2,0]).
bomb([3,0]).
star([2,1]).
star([2,3]).
star([3,2]).


move([X,Y],[X1,Y]):-
    X1 is X + 1.
move([X,Y],[X1,Y]):-
    X1 is X - 1.
move([X,Y],[X,Y1]):-
    Y1 is Y + 1.
move([X,Y],[X,Y1]):-
    Y1 is Y - 1.

unSafestate([V,F]):-
    bomb([V,F]).

getStars([X,Y]):-
    star([X,Y]).

invalid([Point1,Point2],X,Y):-
    Point1 < 0; Point1 > X - 1; Point1 > Y - 1;
    Point2 < 0; Point2 > X - 1; Point2 > Y - 1.

play(X,S):-
    start([Xstart,Ystart]),
    State = [Xstart,Ystart],
    end([X1,Y1]),
    End  = [X1,Y1],
    path(State,End,[State],0,X,S),
    write("\n"),
    printres(X).

path(End,End,X,S,X,S).

path(State,End,Visited,Stars,X,S):-
    dim(Xdim,Ydim),
    move(State,[V1,V2]),
    not(invalid([V1,V2],Xdim,Ydim)),
    not(unSafestate([V1,V2])),
    not(member([V1,V2],Visited)),
    (getStars([V1,V2]) -> Temp is Stars + 1; Temp is Stars),
    path([V1,V2],End,[[V1,V2]|Visited],Temp,X,S).


printres([]).
printres([H|T]):-
    printres(T),
    write(H),
    write("\n").














