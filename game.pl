:-include('faktaPlayer.pl').
:-include('tokemon.pl').
:-include('primitif.pl').
:-include('move.pl').
:-include('map.pl').

/* Initiation */
chooseTokemon :-repeat, write('Choose Your Tokemon : '), nl,
				   write('1. seamon'), nl,
				   write('2. jonemon'), nl,
				   write('3. lemon'), nl, 
				   write('> '), read(X), firstTokemon(X).
               

init :- asserta(state(inGame)), asserta(state(inMap)),
        asserta(nbInv(1)), initTokemon, asserta(playerloc(1,1)), chooseTokemon(Tokemon), health(Tokemon, X), asserta(inventory(Tokemon, X)).

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
pick(Tokemon) :- nbInv(0), lose.
pick(Tokemon) :- state(inBattle), inventory(Tokemon, Health), asserta(currTokemon(Tokemon, Health)), retract(inventory(Tokemon, Health)), 
                 nbInv(Sum), NewSum is (Sum - 1), retract(nbInv(Sum)), asserta(nbInv(NewSum)), battleStat.
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
fight :- write('Choose your tokemon!'), nl, printAvailTokemon.
battleStat :- nl, currEnemy(Enemy, Health1), type(enemy, X), write(Enemy), nl, write('Health : '), write(Health1), nl, write('Type : '), write(X), nl,
              nl, currTokemon(Tokemon, Health2), type(Tokemon, Y), write(Tokemon), nl, write('Health : '), write(Health2), nl, write('Type : '), write(Y), nl.

/* Enemy Attack */
enemyAtkProb(X) :- random(1, 5, X).
//Special Attack//
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = fire, Y1 = grass, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = grass, Y1 = water, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = water, Y1 = fire, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = grass, Y1 = fire, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = water, Y1 = grass, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = fire, Y1 = water, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
//Normal Attack//
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = fire, Y1 = grass, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = grass, Y1 = water, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = water, Y1 = fire, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = grass, Y1 = fire, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = water, Y1 = grass, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
enemyAtk(X) :- X /== 1, currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2), type(Tokemon, Y1), 
               X1 = fire, Y1 = water, retract(currTokemon(Tokemon, Health2)), NewHealth is (Health2 - Att/2), 
               asserta(currTokemon(Tokemon, NewHealth)).
 
enemyAtkProc :- enemyAtkProb(X), enemyAtk(X).