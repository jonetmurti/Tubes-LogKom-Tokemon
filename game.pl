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
inventory(Name, X).

/* MAP */
drawMap(Symbol,X,Y) :- 

/* GAME */
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
          !.

