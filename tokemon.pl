/* Tokemon DataBase */
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

/* First Tokemon choose */
firstTokemon(seamon).
firstTokemon(jonemon).
firstTokemon(lemon).

/* Randomize tokemon position in map */
randomTokemonPos(X, Y, Xlist, Ylist) :- repeat, random(0, 10, X), random(0, 10, Y), isMember(X, Xlist, ExistX), isMember(Y, Xlist, ExistY), ExistX == 0, ExistY == 0.

/* Tokemon Position in Map(changing over time) */
:- dynamic(tokemonPos/3).
initTokemon :- random(0, 10, X1), random(0, 10, Y1), asserta(tokemonPos(rahamon, X1, Y1)),
               random(0, 10, X2), random(0, 10, Y2), asserta(tokemonPos(logkomon, X2, Y2)),
               random(0, 10, X3), random(0, 10, Y3), asserta(tokemonPos(hizmon, X3, Y3)),
               random(0, 10, X4), random(0, 10, Y4), asserta(tokemonPos(seamon, X4, Y4)),
               random(0, 10, X5), random(0, 10, Y5), asserta(tokemonPos(jonemon, X5, Y5)),
               random(0, 10, X6), random(0, 10, Y6), asserta(tokemonPos(mamaLemon, X6, Y6)),
               random(0, 10, X7), random(0, 10, Y7), asserta(tokemonPos(lemon, X7, Y7)),
               random(0, 10, X8), random(0, 10, Y8), asserta(tokemonPos(kemon, X8, Y8)),
               random(0, 10, X9), random(0, 10, Y9), asserta(tokemonPos(suketmon, X9, Y9)).

delTokemonPos :- forall(tokemonPos(Tokemon, X, Y), retract(tokemonPos(Tokemon, X, Y))).

updateTokemonPos :- delTokemonPos, initTokemon.

/* current player tokemon in battle (Tokemon, health) */
:- dynamic(currTokemon/2).
currTokemon :- write('You haven\'t choose your Tokemon').

/* current enemy tokemon in battle (Tokemon, health) */ 
:- dynamic(currEnemy/2).

/* Tokemon Inventory */
/* Inventory  (Tokemon, Health) */
:- dynamic(inventory/2).
/* nbInv  (number), number of tokemon in inventory */
:- dynamic (nbInv/1).

/* Healing Tokemon in GYM */
healTokemon :- forall(inventory(Tokemon, Health), procHeal(Tokemon, Health)).
procHeal(Tokemon, Health) :- retract(inventory(Tokemon, Health)), health(Tokemon, X), assertz(inventory(Tokemon, X)).

/* creating Tokemon inventory List */
//invList :- 

/* Print Available Tokemon */
printAvailTokemon :- write('Available Tokemon : '), nl,
                     forall(inventory(Tokemon, Health), printTokemonName(Tokemon)).
printTokemonName(Tokemon) :- write('- '), write(Tokemon), nl.