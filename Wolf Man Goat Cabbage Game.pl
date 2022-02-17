move(s(0,0,W,C),s(1,1,W,C)).
move(s(1,1,W,C),s(0,0,W,C)).

move(s(G,0,0,C),s(G,1,1,C)).
move(s(G,1,1,C),s(G,0,0,C)).

move(s(G,0,W,0),s(G,1,W,1)).
move(s(G,1,W,1),s(G,0,W,0)).

move(s(G,0,W,C),s(G,1,W,C)).
move(s(G,1,W,C),s(G,0,W,C)).

unSafe(s(G,M,W,C)):-
    G is W,
    G =\= M.

unSafe(s(G,M,W,C)):-
    G is C,
    G =\= M.

game(State,G):-
    path(State,[State],G).

path(state(1,1,1,1),G,G).

path(State, Visited, G):-
    move(State,NextState),
    not(unsafe(NextState)),
    not(member(NextState, Visited)),
    path(NextState, [NextState| Visited], G).

