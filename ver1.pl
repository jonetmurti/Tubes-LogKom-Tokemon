/* TOKEMON */

/* Legendary */
name(rahamon, legedary).
health(rahamon, 1000).
type(rahamon, fire).
normalAtt(rahamon, 60).
spcAtt(rahamon, 70).

name(logkomon, legedary).
health(logkomon, 1000).
type(logkomon, water).
normalAtt(logkomon, 40).
spcAtt(logkomon, 90).

name(hizmon, legedary).
health(hizmon, 1000).
type(hizmon, grass).
normalAtt(hizmon, 50).
spcAtt(hizmon, 80).

/* Normal */
name(seamon, normal).
health(seamon, 100).
type(seamon, water).
normalAtt(seamon, 20).
spcAtt(seamon, 40).

name(jonemon, normal).
health(jonemon, 190).
type(jonemon, grass).
normalAtt(jonemon, 15).
spcAtt(jonemon, 25).

name(mamaLemon, normal).
health(mamaLemon, 180).
type(mamaLemon, water).
normalAtt(mamaLemon, 15).
spcAtt(mamaLemon, 30).

name(lemon, normal).
health(lemon, 110).
type(lemon, fire).
normalAtt(lemon, 20).
spcAtt(lemon, 35).

name(kemon, normal).
health(kemon, 200).
type(kemon, fire).
normalAtt(kemon, 10).
spcAtt(kemon, 30).

name(suketmon, normal).
health(suketmon, 125).
type(suketmon, grass).
normalAtt(suketmon, 25).
spcAtt(suketmon, 40).

/* PLAYER */
state(Name, State).
position(Name, X, Y).
inventory(Name, A, B, C, D, E, F, Count).

/* MAP */
drawMap(Symbol,X,Y) :- 

/* ERROR MSG */
invalidMove :- write()
invalidCmd :- write()
invalidChoose :- write()

/* HELP */
help :- write('Help :'), nl, nl,
				write('Available Commands : '), nl,
        write('Start --start the game!'), nl, 
        write('Help --show available commands'), nl,
        write('Quit --quit the game'), nl, 
        write('Move : w(North), a(West), s(South), d(East)'), nl,
        write('Map'), nl,
        write('Heal --cure Tokemon in inventory if in gym center'), nl,
        write('Status --show your status'), nl,
        write('Pick(Tokemon) --Capture the Tokemon and store it in your inventory'), nl,
        write('Attack --use only in battle mode'), nl,
        write('SpecialAttack --use only in battle mode'), nl,
        write('Run --When Tokemon appears, you will not fight them'), nl, 
        write('Drop(Tokemon). --Free your Tokemon from inventory'), nl,
        write('save(Filename). --save your game'),nl,
        write('load(Filename). --load previously saved game').

/* GAME */
chooseTokemon(X) :-repeat, write('Choose Your Tokemon : '), nl,
									 write('1. seamon'), nl,
								   write('2. jonemon'), nl,
									 write('3. lemon'), nl, 
									 write('> '), read(X), firstTokemon(X) -> true ; write('Invalid Tokemon'), nl, fail.

firstTokemon(seamon).
firstTokemon(jonemon).
firstTokemon(lemon).

start :-  write('Gotta catch them all!'),nl,nl,
		  		write('Hello there!'),nl, 
          write('Welcome to the world of Tokemon!'),nl,
          write('My name is Aril!'),nl,
          write('People call me the Tokemon Professor!'),nl, 
          write('This world is inhabited by creatures called Tokemon!') ,nl,
          write('There are hundreds of Tokemon loose in Labtek 5!') ,nl,
          write('You can catch them all to get stronger, but what I am really interested in are the 2 legendary Tokemons, Icanmon dan Sangemon.') ,nl,
          write('If you can defeat or capture all those Tokemons I will not kill you.'),nl,nl,
          write('Available commands:'),nl,
          write('start. 			--start the game!'),nl,
          write('help. 				--show available commands'),nl,
          write('quit. 				--quit the game'),nl,
          write('n. s. e. w.	--mov'),nl,
          write('emap. 				--look at the map'),nl, 
          write('heal. 				--cure Tokemon in inventory if in gym center'),nl,
          write('status. 			--show your status'),nl,
          write('save(Filename). --save your game'),nl,
          write('load(Filename). --load previously saved game'),nl,					
          write('Legends:'),nl,
          write('-X = Pagar'),nl,
          write('-P = Player'),nl,
		  		write('-G = Gym'),nl,
          chooseTokemon(Tokemon).



/* Move */
:- dynamic position/3.

w :- position(Nama,X,Y),\+(Y=0),
     YNew is Y - 1,
     asserta(position(Nama,X,YNew)),
     write('Anda bergerak ke utara, anda berada pada tanah kosong.').

w :- position(_,_,Y),Y=0,
     write('Anda berada di ujung utara.').

a :- position(Nama,X,Y),\+(X=0),
     XNew is X - 1,
     asserta(position(Nama,XNew,Y)),
     write('Anda bergerak ke barat, anda berada pada tanah kosong.').

a :- position(_,X,_),X=0,
     write('Anda berada di ujung barat.').


s :- position(Nama,X,Y),mapsize(Xmap,Ymap),Y<Ymap,
     YNew is Y + 1,
     asserta(position(Nama,X,YNew)),
     write('Anda bergerak ke selatan, anda berada pada tanah kosong.').

s :- position(Nama,X,Y),mapsize(Xmap,Ymap),Y=Ymap,
     write('Anda berada di ujung selatan').

d :- position(Nama,X,Y),mapsize(Xmap,Ymap),X<Xmap,
     XNew is X + 1,
     asserta(position(Nama,XNew,Y)),
     write('Anda bergerak ke selatan, anda berada pada tanah kosong.').

d :- position(Nama,X,Y),mapsize(Xmap,Ymap),X=Xmap,
     write('Anda berada di ujung timur').


/*STATUS*/
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
  
  /* PETA */
  cetakBorderAtas(0) :- nl,!.

cetakBorderAtas(X) :-
  write('X'),
  X2 is X - 1,
  cetakBorderAtas(X2),!.

cetakBorder :-
 write('X'),!.

cetakField(X,Y) :-
 X > Y,
 !.

cetakField(X,Y) :-
 \+(X > Y),
 write('-'),
 X2 is X + 1,
 cetakField(X2,Y).

cetakBaris(X,Y,Z) :- 
  Y>Z, !.

cetakBaris(X,Y,Z) :-
 \+(Y>Z),
 cetakBorder,
 cetakField(1,X),
 cetakBorder,nl,
 Y2 is Y + 1,
 cetakBaris(X,Y2,Z),!. 

cetakPeta(X,Y) :-
 X2 is X + 2,
 cetakBorderAtas(X2),
 cetakBaris(X,1,Y),
 cetakBorderAtas(X2),!.
