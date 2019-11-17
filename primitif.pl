/* PRIMITIF */
sambung([], X, X).
sambung([A|B], X, [A|C]) :- sambung(B, X, C).

isMember(X, [], 0).
isMember(X, [A|B], 1) :- X == A.
isMember(X, [A|B], Y) :- isMember(X, B, Y1) , Y is Y1.

listkosong(X) :- X = [].