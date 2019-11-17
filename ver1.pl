:- dynamic(playerloc/2).

/* PLAYER */
:- dynamic(state/1). 

/* MAP */
drawMap(Symbol,X,Y) :- !.
gymLoc(4,4).

/* ERROR MSG */
invalidMove :- write()
invalidCmd :- write('Invalid Command !').
invalidChoose :- write()

/* HELP */


/* GAME */


cekLoc :- playerloc(X, Y), tokemonPos(Tokemon, X, Y), write('Fight or Run : '), read(Choose), prob(P), processCmd(Choose, P).
cekLoc :- playerloc(X, Y), gymLoc(X, Y), retract(state(_)), asserta(state(inGym)).
cekLoc :- retract(state(_)), asserta(state(inMap)).

processCmd(Cmd) :- Cmd == w, w, cekLoc.
processCmd(Cmd) :- Cmd == a, a, cekLoc.
processCmd(Cmd) :- Cmd == s, s, cekLoc. 
processCmd(Cmd) :- Cmd == d, d, cekLoc.
processCmd(Cmd) :- Cmd == map, \+state(inBattle), .
processCmd(Cmd) :- Cmd == heal.
processCmd(Cmd) :- Cmd == status,
processCmd(Cmd, Tokemon) :- Cmd == attack, 
processCmd(Cmd, Tokemon) :- Cmd == specialAttack,
processCmd(Cmd) :- Cmd == run.
processCmd(Cmd) :- Cmd == fight, 
processCmd(Cmd) :- Cmd == drop,
processCmd(Cmd) :- Cmd == save,
processCmd(Cmd) :- Cmd == load,
processCmd(Cmd) :- Cmd == help, help.
processCmd(Cmd) :- invalidCmd.
pick(Tokemon) :- 

gameLoop :- repeat, write('Command Input : '), read(Cmd), Cmd == quit , processCmd(Cmd).
battle(Tokemon) :- repeat, write('Command Input : '), read(Cmd), health(Tokemon, X), X == 0, processCmd(Cmd).





/* Move */
/*
w :- playerloc(X,Y),\+(Y=0),
     YNew is Y - 1,
     asserta(playerloc(X,YNew)),
     write('Anda bergerak ke utara, anda berada pada tanah kosong.').

w :- playerloc(_,Y),Y=0,
     write('Anda berada di ujung utara.').

a :- playerloc(X,Y),\+(X=0),
     XNew is X - 1,
     asserta(playerloc(XNew,Y)),
     write('Anda bergerak ke barat, anda berada pada tanah kosong.').

a :- playerloc(X,_),X=0,
     write('Anda berada di ujung barat.').


s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y<Ymap,
     YNew is Y + 1,
     asserta(playerloc(X,YNew)),
     write('Anda bergerak ke selatan, anda berada pada tanah kosong.').

s :- playerloc(X,Y),mapsize(Xmap,Ymap),Y=Ymap,
     write('Anda berada di ujung selatan').

d :- playerloc(X,Y),mapsize(Xmap,Ymap),X<Xmap,
     XNew is X + 1,
     asserta(playerloc(XNew,Y)),
     write('Anda bergerak ke selatan, anda berada pada tanah kosong.').

d :- playerloc(X,Y),mapsize(Xmap,Ymap),X=Xmap,
     write('Anda berada di ujung timur').

*/
/*STATUS*/
/*
status:-
	write("Your Tokemon:"),nl,
	forall(capture(X),
  (write(X),nl,
	write("Health: "),Health(X, Y),nl,write(Y),nl,
	write("Type: "),type(X,Z),nl,write(Z),nl
  ))!.
status:-	
	write("Your enemy: "),
  forall(+/capture(X),
	(write(X),nl,
	write("Health: "),Health(X, Y),nl,write(Y),nl,
	write("Type: "),type(X,Z),nl,write(Z),nl
  ))!.
*/