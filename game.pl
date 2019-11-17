:-include('faktaPlayer.pl').
:-include('tokemon.pl').
:-include('primitif.pl').
:-include('move.pl').
:-include('map.pl').

/* The game state */
:- dynamic(state/1).

/* Randomize tokemon position in map */
randomTokemonPos(X, Y, Xlist, Ylist) :- repeat, random(0, 10, X), random(0, 10, Y), isMember(X, Xlist, ExistX), isMember(Y, Ylist, ExistY), ExistX == 0, ExistY == 0.

/* Initiation */
chooseTokemon :-repeat, write('Choose Your Tokemon : '), nl,
				   write('1. seamon'), nl,
				   write('2. jonemon'), nl,
				   write('3. lemon'), nl, 
				   write('> '), read(X), startTokemon(X), asserta(firstTokenmon).


initTokemon :- X1List = [], Y1List = [], randomTokemonPos(X1, Y1, X1List, Y1List), asserta(tokemonPos(seamon, X1, Y1)), sambung(X1List, X1, X2List), sambung(Y1List, Y1, Y2List),
               randomTokemonPos(X2, Y2, X2List, Y2List), asserta(tokemonPos(jonemon, X2, Y2)), sambung(X2List, X2, X3List), sambung(Y2List, Y2, Y3List),
               randomTokemonPos(X3, Y3, X3List, Y3List), asserta(tokemonPos(mamaLemon, X3, Y3)), sambung(X3List, X3, X4List), sambung(Y3List, Y3, Y4List),
               randomTokemonPos(X4, Y4, X4List, Y4List), asserta(tokemonPos(lemon, X4, Y4)), sambung(X4List, X4, X5List), sambung(Y4List, Y4, Y5List),
               randomTokemonPos(X5, Y5, X5List, Y5List), asserta(tokemonPos(kemon, X5, Y5)), sambung(X5List, X5, X6List), sambung(Y5List, Y5, Y6List),
               randomTokemonPos(X6, Y6, X6List, Y6List), asserta(tokemonPos(suketmon, X6, Y6)), sambung(X6List, X6, X7List), sambung(Y6List, Y6, Y7List),
               randomTokemonPos(X7, Y7, X7List, Y7List), asserta(tokemonPos(rahamon, X7, Y7)), sambung(X7List, X7, X8List), sambung(Y7List, Y7, Y8List),
               randomTokemonPos(X8, Y8, X8List, Y8List), asserta(tokemonPos(logkomon, X8, Y8)), sambung(X8List, X8, X9List), sambung(Y8List, Y8, Y9List),
               randomTokemonPos(X9, Y9, X9List, Y9List), asserta(tokemonPos(hizmon, X9, Y9)).
               

init :- chooseTokemon, firstTokemon(Tokemon), health(Tokemon, X), asserta(inventory(Tokemon, X)), asserta(state(inGame)), asserta(state(inMap)),
        asserta(nbInv(1)), initTokemon, asserta(playerloc(1,1)).

/* Start Game */
start :-  write('Gotta catch them all!'),nl,nl,
		  write('Hello there!'),nl, 
          write('Welcome to the world of Tokemon!'),nl,
          write('My nama is Aril!'),nl,
          write('People call me the Tokemon Professor!'),nl, 
          write('This world is inhabited by creatures called Tokemon!') ,nl,
          write('There are hundreds of Tokemon loose in Labtek 5!') ,nl,
          write('You can catch them all to get stronger, but what I am really interested in are the 2 legendary Tokemons, Icanmon dan Sangemon.') ,nl,
          write('If you can defeat or capture all those Tokemons I will not kill you.'),nl,nl,
          write('Available commands:'),nl,
          write('start. 			--start the game!'),nl,
          write('help. 				--show available commands'),nl,
          write('quit. 				--quit the game'),nl,
          write('w. a. s. d.		--mov'),nl,
          write('emap. 				--look at the map'),nl, 
          write('heal. 				--cure Tokemon in inventory if in gym center'),nl,
          write('status. 			--show your status'),nl,
          write('save(Filenama). 	--save your game'),nl,
          write('load(Filenama). 	--load previously saved game'),nl,					
          write('Legends:'),nl,
          write('-X = Pagar'),nl,
          write('-P = Player'),nl,
		  write('-G = Gym'),nl,
          init.

/* COMMAND : */

/* Help command */
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
        write('save(Filenama). --save your game'),nl,
        write('load(Filenama). --load previously saved game').

/* Heal Command */
heal :- state(inGym), healTokemon.
heal :- state(inGame), write('You are not in the gym!'), nl.
heal :- write('You are not in Game!'), nl.

/* Pick Command */
pick(Tokemon) :- state(inBattle), inventory(Tokemon, Health), asserta(currTokemon(Tokemon, Health)), retract(inventory(Tokemon, Health)), battleStat.
pick(Tokemon) :- state(inBattle), write('You don’t have that Tokemon!'), nl.
pick(Tokemon) :- state(inGame), write('You are not in Battle!'), nl.
pick(Tokemon) :- write('You are not in Game!'), nl.

/* Attack Command */
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = fire, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = grass, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = water, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = grass, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = water, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = fire, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inBattle), currTokemon(Tokemon, Health1), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), 
          retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att), asserta(currEnemy(Enemy, NewHealth)).
attack :- state(inGame), write('You are not in battle!'), nl.
attack :- write('You are not in Game!'), nl.

/* Special Attack Command */
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = fire, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = grass, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = water, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = grass, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = water, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = fire, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att/2), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), 
                 retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att), asserta(currEnemy(Enemy, NewHealth)).
specialAttack :- state(inGame), write('You are not in battle!'), nl.
specialAttack :- write('You are not in Game!'), nl.

/* Drop Command */
drop(Tokemon) :- inventory(Tokemon, Health), retract(inventory(Tokemon, Health)).
drop(Tokemon) :- state(inGame), write('You don\'t have that Tokemon!'), nl.
drop(Tokemon) :- write('You are not in Game!'), nl.

/* Run Command */
runProb(X) :- random(1, 4, X).
run :- state(inBattle), runProb(X), X == 1, write('You failed to run'), nl, fight.
run :- state(inBattle), retract(currEnemy(X, Y)), retract(state(inBattle)), asserta(state(inMap)), write('You sucessfully escaped the Tokemon!'), nl.
run :- state(inGame), write('You are not in battle!'), nl.
run :- write('You are not in Game!'), nl.

/* Quit Command */
quit :- forall(tokemonPos(X, Y, Z), retract(tokemonPos(X, Y, Z))), forall(state(X1), retract(state(X1))), forall(currTokemon(X2,Y2), retract(currTokemon(X2,Y2))),
        forall(currEnemy(X3,Y3), retract(currEnemy(X3,Y3))), forall(inventory(X4, Y4), retract(inventory(X4, Y4))), forall(nbInv(X5), retract(nbInv(X5))).

/* Battle Phase */
battleQuestion :- write('A wild tokemon appears!'), nl, write('Fight or Run ?'), nl.
fight :- write('Choose your tokemon!'), nl, printAvailTokemon.
battleStat :- nl, currEnemy(Enemy, Health1), type(enemy, X), write(Enemy), nl, write('Health : '), write(Health1), nl, write('Type : '), write(X), nl,
              nl, currTokemon(Tokemon, Health2), type(Tokemon, Y), write(Tokemon), nl, write('Health : '), write(Health2), nl, write('Type : '), write(Y), nl.

/* Enemy Attack */
