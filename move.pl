:- include('faktaPlayer.pl').
:- include('map.pl').
:- include('tokemon.pl').

/* Move */

w :- \+state(inGame),
     write('Anda belum memulai game!!').

w :- playerloc(X,Y),\+(Y=1),
     YNew is Y - 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(X,YNew)),
     write('Anda bergerak ke utara, anda berada pada tanah kosong.').

w :- playerloc(_,Y),Y=1,
     write('Anda berada di ujung utara.').

a :- \+state(inGame),
     write('Anda belum memulai game!!').

a :- playerloc(X,Y),\+(X=1),
     XNew is X - 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(XNew,Y)),
     write('Anda bergerak ke barat, anda berada pada tanah kosong.').

a :- playerloc(X,_),X=1,
     write('Anda berada di ujung barat.').

s :- \+state(inGame),
     write('Anda belum memulai game!!').

s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y<Ymap,
     YNew is Y + 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(X,YNew)),
     write('Anda bergerak ke selatan, anda berada pada tanah kosong.').

s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y=Ymap,
     write('Anda berada di ujung selatan').

d :- \+state(inGame),
     write('Anda belum memulai game!!').

d :- playerloc(X,Y),mapsize(Xmap,Ymap),X<Xmap,
     XNew is X + 1,
     retract(playerloc(X,Y)),
     asserta(playerloc(XNew,Y)),
     write('Anda bergerak ke timur, anda berada pada tanah kosong.').

d :- playerloc(X,Y),mapsize(Xmap,Ymap),X=Xmap,
     write('Anda berada di ujung timur').

/* Location Check after every move */
cekLoc :- playerloc(X, Y), gymLoc(X1, Y1), X == X1, Y == Y1, retract(state(_)), asserta(state(inGym)).
cekLoc :- playerloc(X, Y), tokemonPos(Tokemon, X1, Y1), X == X1, Y == Y1, health(Tokemon, Health), 
          retract(state(_)), asserta(state(inBattle)), asserta(currEnemy(Tokemon, Health)), 
          write('A wild tokemon appears!'), nl, write('Fight or Run ?'), nl.
cekLoc :- retract(state(_)), asserta(state(inMap)).