:- include('faktaPlayer.pl').
:- include('map.pl').
:- include('tokemon.pl').

/* Move */

w :- \+state(_),
     write('Anda belum memulai game!!'), nl,!.
w :- state(inBattle), write('You cannot move in battle!'), nl.
w :- playerloc(X,Y),\+(Y=1),
     YNew is Y - 1,
     pagar(X,YNew),
     write('Ada pagar coy.'), nl,!.
w :- playerloc(X,Y),\+(Y=1),
     YNew is Y - 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(X,YNew)), cetakPeta,
     write('Anda bergerak ke utara.'), nl, updateTokemonPos, cekLoc,!.

w :- playerloc(_,Y),Y=1, cetakPeta,
     write('Anda berada di ujung utara.'), nl,!.

a :- \+state(_),
     write('Anda belum memulai game!!'), nl,!.
a :- state(inBattle), write('You cannot move in battle!'), nl,!.
a :- playerloc(X,Y),\+(X=1),
     XNew is X - 1,
     pagar(XNew,Y),
     write('Gaboleh lompat pagar yaaa.'), nl,!.
a :- playerloc(X,Y),\+(X=1),
     XNew is X - 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(XNew,Y)), cetakPeta,
     write('Anda bergerak ke barat.'), nl, updateTokemonPos, cekLoc,!.

a :- playerloc(X,_),X=1, cetakPeta,
     write('Anda berada di ujung barat.'), nl,!.

s :- \+state(_),
     write('Anda belum memulai game!!'), nl,!.
s :- state(inBattle), write('You cannot move in battle!'), nl,!.
s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y<Ymap,
     YNew is Y + 1,
     pagar(X,YNew),
     write('Ada pagar lhoo.'), nl,!.
s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y<Ymap,
     YNew is Y + 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(X,YNew)), cetakPeta,
     write('Anda bergerak ke selatan.'), nl, updateTokemonPos, cekLoc,!.

s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y=Ymap, cetakPeta,
     write('Anda berada di ujung selatan'), nl,!.

d :- \+state(_),
     write('Anda belum memulai game!!'), nl,!.
d :- state(inBattle), write('You cannot move in battle!'), nl,!.
d :- playerloc(X,Y),mapsize(Xmap,Ymap),X<Xmap,
     XNew is X + 1,
     pagar(XNew,Y),
     write('Ada pagar loh.'), nl,!.
d :- playerloc(X,Y),mapsize(Xmap,Ymap),X<Xmap,
     XNew is X + 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(XNew,Y)), cetakPeta,
     write('Anda bergerak ke timur.'), nl, updateTokemonPos, cekLoc,!.

d :- playerloc(X,Y),mapsize(Xmap,Ymap),X=Xmap, cetakPeta,
     write('Anda berada di ujung timur'), nl,!.

/* Location Check after every move */
cekLoc :- playerloc(X, Y), gymLoc(X1, Y1), X == X1, Y == Y1, retract(state(_)), asserta(state(inGym)),!.
cekLoc :- playerloc(X, Y), tokemonPos(Tokemon, X1, Y1), X == X1, Y == Y1, health(Tokemon, Health), 
          retract(state(_)), asserta(state(inBattle)), asserta(currEnemy(Tokemon, Health)), 
          write('A wild tokemon appears!'), nl, write('Tokemon : '), write(Tokemon), nl, 
          write('Type : '), type(Tokemon, Type), write(Type), nl, 
          write('Health : '), write(Health), nl, nl, write('Fight or Run ?'), nl,!.
cekLoc :- retract(state(_)), asserta(state(inMap)), buang, !.
buang :- \+currCapture(_).
buang :- currCapture(X), retract(currCapture(X)), !.