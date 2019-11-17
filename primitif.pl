/* PRIMITIF */
append([], X, X).
append([A|B], X, [A|C]) :- append(B, X, C).

isMember(X, [], 0).
isMember(X, [A|B], 1) :- X == A.
isMember(X, [A|B], Y) :- isMember(X, B, Y1) , Y is Y1.