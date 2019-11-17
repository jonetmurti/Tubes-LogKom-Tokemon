gymLoc(4,4).

cetakBorderH(0) :- nl,!.

cetakBorderH(X) :-
    cetakBorder,
    X2 is X - 1,
    cetakBorderH(X2),!.


cetakBorder :-
    write('X'),!.


cetakField(A,X,B) :-
    A>X, !.

cetakField(A,X,B) :-
    \+playerloc(A,B),
    \+(A > X),
    \+(gymLoc(A,B)),
    write('-'),
    A2 is A + 1,
    cetakField(A2,X,B).

cetakField(A,X,B) :-
    \+(A > X),
    gymLoc(A,B),
    write('G'),
    A2 is A + 1,
    cetakField(A2,X,B).

cetakField(A,X,B) :-
    \+(A > X),
    playerloc(A,B),
    write('P'),
    A2 is A + 1,
    cetakField(A2,X,B).


cetakBaris(X,B,Y) :- 
    B>Y, !.

cetakBaris(X,B,Y) :-
    \+(B>Y),
    cetakBorder,
    cetakField(1,X,B),
    cetakBorder,nl,
    B2 is B + 1,
    cetakBaris(X,B2,Y),!. 


Map :-
    mapsize(X,Y),
    X2 is X + 2,
    cetakBorderH(X2),
    cetakBaris(X,1,Y),
    cetakBorderH(X2),!.