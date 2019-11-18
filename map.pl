:-include('faktaPlayer.pl').

gymLoc(4,4).
pagar(3,5).
pagar(4,5).
pagar(4,6).
pagar(4,7).
pagar(5,8).
pagar(6,9).
pagar(5,5).
pagar(6,5).
pagar(7,5).
pagar(8,5).


cetakBorderH(0) :- nl,!.

cetakBorderH(X) :-
    cetakBorder,
    X2 is X - 1,
    cetakBorderH(X2),!.


cetakBorder :-
    write('X'),!.


cetakField(A,X,_) :-
    A>X, !.

cetakField(A,X,B) :-
    \+playerloc(A,B),
    \+(A > X),
    \+(gymLoc(A,B)),
    \+pagar(A,B),
    write('-'),
    A2 is A + 1,
    cetakField(A2,X,B).

map : cetakPeta.

cetakField(A,X,B) :-
    \+(A > X),
    \+playerloc(A,B),
    gymLoc(A,B),
    write('G'),
    A2 is A + 1,
    cetakField(A2,X,B).

cetakField(A,X,B) :-
    \+(A > X),
    pagar(A,B),
    write('X'),
    A2 is A + 1,
    cetakField(A2,X,B).

cetakField(A,X,B) :-
    \+(A > X),
    playerloc(A,B),
    write('P'),
    A2 is A + 1,
    cetakField(A2,X,B).

cetakBaris(_,B,Y) :- 
    B>Y, !.

cetakBaris(X,B,Y) :-
    \+(B>Y),
    cetakBorder,
    cetakField(1,X,B),
    cetakBorder,nl,
    B2 is B + 1,
    cetakBaris(X,B2,Y),!. 


cetakPeta :-
    write('Legends:'),nl,
    write('-X = Pagar'),nl,
    write('-P = Player'),nl,
    write('-G = Gym'),nl,
    mapsize(X,Y),
    X2 is X + 2,
    cetakBorderH(X2),
    cetakBaris(X,1,Y),
    cetakBorderH(X2),!.
