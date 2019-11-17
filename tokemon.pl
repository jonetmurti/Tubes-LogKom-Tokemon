/* Tokemon DataBase */
/* Legendary */
nama(rahamon, legedary).
health(rahamon, 1000).
type(rahamon, fire).
normalAtt(rahamon, 60).
spcAtt(rahamon, 70).

nama(logkomon, legedary).
health(logkomon, 1000).
type(logkomon, water).
normalAtt(logkomon, 40).
spcAtt(logkomon, 90).

nama(hizmon, legedary).
health(hizmon, 1000).
type(hizmon, grass).
normalAtt(hizmon, 50).
spcAtt(hizmon, 80).

/* Normal */
nama(seamon, normal).
health(seamon, 100).
type(seamon, water).
normalAtt(seamon, 20).
spcAtt(seamon, 40).

nama(jonemon, normal).
health(jonemon, 190).
type(jonemon, grass).
normalAtt(jonemon, 15).
spcAtt(jonemon, 25).

nama(mamaLemon, normal).
health(mamaLemon, 180).
type(mamaLemon, water).
normalAtt(mamaLemon, 15).
spcAtt(mamaLemon, 30).

nama(lemon, normal).
health(lemon, 110).
type(lemon, fire).
normalAtt(lemon, 20).
spcAtt(lemon, 35).

nama(kemon, normal).
health(kemon, 200).
type(kemon, fire).
normalAtt(kemon, 10).
spcAtt(kemon, 30).

nama(suketmon, normal).
health(suketmon, 125).
type(suketmon, grass).
normalAtt(suketmon, 25).
spcAtt(suketmon, 40).

/* First Tokemon choose */
startTokemon(seamon).
startTokemon(jonemon).
startTokemon(lemon).

/* Randomize tokemon position in map */
randomTokemonPos(X, Y, Xlist, Ylist) :- repeat, random(1, 11, X), random(1, 11, Y), isMember(X, Xlist, ExistX), isMember(Y, Xlist, ExistY), ExistX == 0, ExistY == 0.

/* Tokemon Position in Map(changing over time) */
:- dynamic(tokemonPos/3).
initTokemon :- random(1, 11, X1), random(1, 11, Y1), asserta(tokemonPos(rahamon, X1, Y1)),
               random(1, 11, X2), random(1, 11, Y2), asserta(tokemonPos(logkomon, X2, Y2)),
               random(1, 11, X3), random(1, 11, Y3), asserta(tokemonPos(hizmon, X3, Y3)),
               random(1, 11, X4), random(1, 11, Y4), asserta(tokemonPos(seamon, X4, Y4)),
               random(1, 11, X5), random(1, 11, Y5), asserta(tokemonPos(jonemon, X5, Y5)),
               random(1, 11, X6), random(1, 11, Y6), asserta(tokemonPos(mamaLemon, X6, Y6)),
               random(1, 11, X7), random(1, 11, Y7), asserta(tokemonPos(lemon, X7, Y7)),
               random(1, 11, X8), random(1, 11, Y8), asserta(tokemonPos(kemon, X8, Y8)),
               random(1, 11, X9), random(1, 11, Y9), asserta(tokemonPos(suketmon, X9, Y9)).

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
:- dynamic(nbInv/1).

/* Healing Tokemon in GYM */
healTokemon :- forall(inventory(Tokemon, Health), procHeal(Tokemon, Health)).
procHeal(Tokemon, Health) :- retract(inventory(Tokemon, Health)), health(Tokemon, X), assertz(inventory(Tokemon, X)).

/* creating Tokemon inventory List */
/* invList :- */

/* Print Available Tokemon */
printAvailTokemon :- write('Available Tokemon : '), nl,
                     forall(inventory(Tokemon, Health), printTokemonName(Tokemon)).
printTokemonName(Tokemon) :- write('- '), write(Tokemon), nl.
 
