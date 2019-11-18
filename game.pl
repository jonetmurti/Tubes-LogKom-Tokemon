:-include('faktaPlayer.pl').
:-include('tokemon.pl').
:-include('primitif.pl').
:-include('move.pl').
:-include('map.pl').

/* Initiation */
chooseTokemon :-repeat, write('Choose Your Tokemon : (Write the name of the Tokemon)'), nl,
				        write('1. seamon'), nl,
				        write('2. jonemon'), nl,
				        write('3. lemon'), nl, 
				        write('> '), read(X), firstTokemon(X),health(X,Y),asserta(inventory(X,Y)).
               

init :- retract(state(_)), asserta(state(inGame)), asserta(state(inMap)), asserta(alreadyHeal(0)), asserta(nLegend(3)),
        asserta(nbInv(1)), initTokemon, asserta(playerloc(1,1)), chooseTokemon,nl, cetakPeta,  
        !.

/* Start Game */
start :- state(_), write('Anda sudah berada didalam game.'),!.
start :-  
        write('Ah, hello there Trainer, Welcome to Labo Fennef City. '),nl,
        write('My name is Faris, I am the Mayor of the City.'),nl,
        write('As you may already know, some wild Tokemons has been causing disturbance around the city.'), nl,
        write('Those wild Tokemons are led by three Legendary Tokemons'),nl,
        write('Those three are Rahamon, Logkomon, and Hizmon.'),nl,
        write('We need someone to get rid of those Tokemons, and we believe you are the right person, Trainer'),nl,
        write('Your task, is to defeat or subdue two of the three Legendary Tokemons'),nl,
        write('Do not worry, we already prepare a Tokemon that will help you get rid of those wild Tokemon.'),nl,
        write('Now, please choose the Tokemon you like, and good luck!'),nl,nl,
        write('Available commands:'),nl,
        write('start            --start the game!'), nl, 
        write('help             --show available commands'), nl,
        write('quit             --quit the game'), nl, 
        write('w, a, s, d       --mov'),nl,
        write('map              --show current map'), nl,
        write('heal             --cure Tokemon in inventory if in gym center'), nl,
        write('status           --show your status'), nl,
        write('save(Filenama)   --save your game'),nl,
        write('load(Filenama)   --load previously saved game'),nl,
	write('Note: setiap perintah harus diakhiri titik (.)'),nl,					
        init,!.
start :- state(_), write('Anda sudah berada didalam game.'),!.

/* COMMAND : */

/* Help command */
help :- write('Help :'), nl, nl,
	write('Available Commands : '), nl,
        write('start            --start the game!'), nl, 
        write('help             --show available commands'), nl,
        write('quit             --quit the game'), nl, 
        write('move : w(North), a(West), s(South), d(East)'), nl,
        write('map              --show current map'), nl,
        write('heal             --cure Tokemon in inventory if in gym center'), nl,
        write('status           --show your status'), nl,
        write('pick(Tokemon)    --Capture the Tokemon and store it in your inventory'), nl,
        write('attack           --use only in battle mode'), nl,
        write('specialAttack    --use only in battle mode'), nl,
        write('run              --When Tokemon appears, you will not fight them'), nl, 
        write('drop(Tokemon).   --Free your Tokemon from inventory'), nl,
        write('save(Filenama).  --save your game'),nl,
        write('load(Filenama).  --load previously saved game'),nl,
	write('Note: setiap perintah harus diakhiri titik (.)'),nl.

/* Heal Command */
heal :- state(inGym), alreadyHeal(0), retract(alreadyHeal(0)), asserta(alreadyHeal(1)), healTokemon, !.
heal :- state(inGym), alreadyHeal(1), write('Command ini hanya bisa digunakan 1 kali!'), nl, !.
heal :- state(inGame), write('You are not in the gym!'), nl, !.
heal :- write('You are not in Game!'), nl, !.

/* Pick Command */
pick(Tokemon) :- state(inBattle), inventory(Tokemon, Health), asserta(currTokemon(Tokemon, Health, 1)), retract(inventory(Tokemon, Health)), 
                 nbInv(Sum), NewSum is (Sum - 1), retract(nbInv(Sum)), asserta(nbInv(NewSum)), battleStat,!.
pick(Tokemon) :- state(inBattle), write('You don’t have that Tokemon!'), nl,!.
pick(Tokemon) :- state(inGame), write('You are not in Battle!'), nl,!.
pick(Tokemon) :- write('You are not in Game!'), nl,!.

/* Attack Command */
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = fire, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = grass, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = water, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = grass, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = water, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), type(Tokemon, X), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
          X = fire, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), normalAtt(Tokemon, Att), currEnemy(Enemy, Health2), 
          retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
attack :- state(inGame), write('You are not in battle!'), nl, !.
attack :- write('You are not in Game!'), nl, !.

/* Special Attack Command */
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = fire, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)),  type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = grass, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = water, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = grass, Y = fire, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = water, Y = grass, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), type(Tokemon, X), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), type(Enemy, Y), 
                 X = fire, Y = water, retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att//2), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 1, retract(currTokemon(Tokemon, Health1, Spc)), 
                 NewSpc is Spc - 1, asserta(currTokemon(Tokemon, Health1, NewSpc)), spcAtt(Tokemon, Att), currEnemy(Enemy, Health2), 
                 retract(currEnemy(Enemy, Health2)), NewHealth is (Health2 - Att), asserta(currEnemy(Enemy, NewHealth)), battleEval1, !.
specialAttack :- state(inBattle), currTokemon(Tokemon, Health1, Spc), Spc == 0, write('You can only use your special skill once!'), nl, !.
specialAttack :- state(inGame), write('You are not in battle!'), nl, !.
specialAttack :- write('You are not in Game!'), nl, !.

/* Drop Command */
drop(Tokemon) :- inventory(Tokemon, Health), retract(inventory(Tokemon, Health)), retract(nbInv(Sum)), NewSum is Sum - 1, asserta(nbInv(NewSum)), !.
drop(Tokemon) :- state(inGame), write('You don\'t have that Tokemon!'), nl, !.
drop(Tokemon) :- write('You are not in Game!'), nl, !.

/* Run Command */
runProb(X) :- random(1, 7, X), !.
run :- state(inFight), write('You are in the middle of a fight!'), nl, !.
run :- state(inBattle), runProb(X), X == 3, write('You failed to run'), nl, fight, !.
run :- state(inBattle), retract(currEnemy(X, Y)), retract(state(inBattle)), asserta(state(inMap)), write('You sucessfully escaped the Tokemon!'), nl, !.
run :- state(inGame), write('You are not in battle!'), nl,!.
run :- write('You are not in Game!'), nl, !.

/* Quit Command */
quit :- state(inMenu), write('You are not in a game!'), nl, !.
quit :- forall(tokemonPos(X, Y, Z), retract(tokemonPos(X, Y, Z))), forall(state(X1), retract(state(X1))), forall(currTokemon(X2,Y2,Z2), retract(currTokemon(X2,Y2,Z2))),
        forall(currEnemy(X3,Y3), retract(currEnemy(X3,Y3))), forall(inventory(X4, Y4), retract(inventory(X4, Y4))), forall(nbInv(X5), retract(nbInv(X5))), 
        forall(playerloc(X6,Y6), retract(playerloc(X6,Y6))), forall(alreadyHeal(X7), retract(alreadyHeal(X7))), forall(nLegend(X8), retract(nLegend(X8))),nl,
        write('So you prefer to run away, huh?').

/* Capture Command */
capture :- nbInv(X), X == 6, write('Inventory Full! Drop one of your Tokemon first!'), nl, !.
capture :- retract(currCapture(Enemy)), health(Enemy, X), asserta(inventory(Enemy, X)), retract(nbInv(Sum)), NewSum is Sum + 1, asserta(nbInv(NewSum)), !.

/* Battle Phase */
fight :- asserta(state(inFight)), write('Choose your tokemon! (Write pick(name_of_tokemon)'), nl, printAvailTokemon,nl,!.
battleStat :- nl, currEnemy(Enemy, Health1), type(Enemy, X), write(Enemy), nl, write('Health : '), write(Health1), nl, write('Type : '), write(X), nl,
              nl, currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y), write(Tokemon), nl, write('Health : '), write(Health2), nl, write('Type : '), write(Y), nl, !.

battleEval1 :- currEnemy(Enemy, Health), Health > 0, battleStat, enemyAtkProc, write('Enemy attack!'), nl, battleEval2, !.
battleEval1 :- currEnemy(Enemy, Health), nama(Enemy, Type), Type = legendary, nLegend(1), write('You Win! Thanks for playing!'), nl, quit, !.
battleEval1 :- currEnemy(Enemy, Health), nama(Enemy, Type), Type = legendary, nLegend(N), NewN is N - 1, retract(nLegend(N)), asserta(nLegend(NewN)),
               write(Enemy), write(' fainted, you beat one legendary Tokemon!! do you want to capture ?'), nl, 
               retract(tokemonPos(Enemy, X, Y)), retract(currTokemon(Tokemon, Health1, Spc)), asserta(inventory(Tokemon, Health1)), asserta(currCapture(Enemy)),
               retract(state(inBattle)), retract(state(inFight)), asserta(state(inMap)), retract(nbInv(Sum)), NewSum is Sum + 1, asserta(nbInv(NewSum)),
               retract(currEnemy(_,_)), !.
battleEval1 :- currEnemy(Enemy, Health), write(Enemy), write(' fainted, do you want to capture ?'), nl, 
               retract(tokemonPos(Enemy, X, Y)), retract(currTokemon(Tokemon, Health1, Spc)), asserta(inventory(Tokemon, Health1)), asserta(currCapture(Enemy)),
               retract(state(inBattle)), retract(state(inFight)), asserta(state(inMap)), retract(nbInv(Sum)), NewSum is Sum + 1, asserta(nbInv(NewSum)),
               retract(currEnemy(_,_)), !.

battleEval2 :- currTokemon(Tokemon, Health1, Spc), Health1 > 0, battleStat, !.
battleEval2 :- nbInv(X), X > 0, write('Pick another Tokemon!'), nl, retract(currTokemon(Tokemon, Health, Spc)), printAvailTokemon, !.
battleEval2 :- write('You Lose! Thanks for playing!'), nl, quit, !.


/* Enemy Attack */
/*
enemyAtkProb(X) :- random(1, 11, X).
*/
/* Special Attack */
/*
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = fire, Y1 = grass, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = grass, Y1 = water, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = water, Y1 = fire, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = grass, Y1 = fire, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = water, Y1 = grass, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), type(Enemy, X1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = fire, Y1 = water, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk(X) :- X == 1, currEnemy(Enemy, Health1), spcAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), 
               retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)). 
*/
/*Normal Attack*/
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = fire, Y1 = grass, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = grass, Y1 = water, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = water, Y1 = fire, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = grass, Y1 = fire, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = water, Y1 = grass, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), type(Enemy, X1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), type(Tokemon, Y1), 
               X1 = fire, Y1 = water, retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att//2), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)).
enemyAtk :- currEnemy(Enemy, Health1), normalAtt(Enemy, Att), currTokemon(Tokemon, Health2, Spc), 
               retract(currTokemon(Tokemon, Health2, Spc)), NewHealth is (Health2 - Att), 
               asserta(currTokemon(Tokemon, NewHealth, Spc)). 

enemyAtkProc :- enemyAtk.

status :-
	write('Your Tokemon: '),nl,
	forall(inventory(X,Y),(write(X),nl,
	write('Health: '), write(Y),nl,
	write('Tipe: '),type(X,Z),write(Z),nl,nl)),
	write('Your Enemy: '),nl,
	forall((nama(X,legendary),\+inventory(X,_)),(write(X),nl,
	write('Health: '),health(X,Y), write(Y),nl,
	write('Tipe: '),type(X,Z),write(Z),nl,nl)).

map :-
        cetakPeta.
