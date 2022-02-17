processes([p1,p2,p3,p4,p5]).

available_resources([[r1,0 ], [r2, 0]]).

allocated(p1, [r2]).
allocated(p2, [r1]).
allocated(p3, [r1]).
allocated(p4, [r2]).
allocated(p5, []).

requested(p1, [r1]).
requested(p3, [r2]).
requested(p5, [r2]).
deleteE(Element,[Element|Tail],Tail):-!.
  deleteE(Element,[Head|Tail],[Head|Tail1]) :-
        deleteE(Element,Tail,Tail1).

save_state(X):-
    available_resources([[r1,A], [r2,B]]),
    processes(P),
    can_run(X,A,B,P)
    ,write("true").
can_run([],_,_,[]).
can_run([X|T],A,B,P):-
    (
        (
            A=0,
            B=0,
            (allocated(X,[r1]); allocated(X,[r2])),
            not(requested(X,[r2])),
            not(requested(X,[r1]))
        )
        ;
        (
            A>0,
            B=0,
            (allocated(X,[r2]);allocated(X,[r1]);allocated(X,[])),
            (requested(X,[r1]); not(requested(X,[r1]))),
            not(requested(X,[r2]))
        )
        ;
       (
            A=0,
            B>0,
            (allocated(X,[r1]);allocated(X,[r2]);allocated(X,[])),
            not(requested(X,[r1])),
            (requested(X,[r2]); not(requested(X,[r2])))
        )
        ;
        (
            A>0,
            B>0,
            (allocated(X,[r1]); allocated(X,[r2]);allocated(X,[])),
            (requested(X,[r1]);
            requested(X,[r2]);
            not(requested(X,[r2]));
            not(requested(X,[r1])))
            )
    )
    ,
    deleteE(X,P,Res),
    allocated(X, R),
  (R=[]->A1 is A,B1 is B;(R=[r1]->A1 is A+1,B1 is B;A1 is A,B1 is B+1)),
  can_run(T,A1,B1,Res).






