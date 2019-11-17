/* Tokemon DataBase */

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

/* Legendary */

nama(rahamon, legedary).
nama(logkomon, legedary).
nama(hizmon, legedary).
nama(seamon, normal).
nama(kemon, normal).
nama(jonemon, normal).
nama(mamaLemon, normal).
nama(lemon, normal).
nama(suketmon, normal).

health(hizmon, 1000).
health(logkomon, 1000).
health(rahamon, 1000).
health(seamon, 100).
health(jonemon, 190).
health(mamaLemon, 180).
health(lemon, 110).
health(suketmon, 125).
health(kemon, 200).

type(rahamon, fire).
type(logkomon, water).
type(hizmon, grass).
type(seamon, water).
type(jonemon, grass).
type(mamaLemon, water).
type(lemon, fire).
type(kemon, fire).
type(suketmon, grass).

normalAtt(rahamon, 60).
normalAtt(logkomon, 40).
normalAtt(hizmon, 50).
normalAtt(seamon, 20).
normalAtt(jonemon, 15).
normalAtt(mamaLemon, 15).
normalAtt(lemon, 20).
normalAtt(kemon, 10).
normalAtt(suketmon, 25).

%spesial attact spcAtt/2
spcAtt(rahamon, 70).
spcAtt(logkomon, 90).
spcAtt(hizmon, 80).
spcAtt(seamon, 40).
spcAtt(jonemon, 25).
spcAtt(mamaLemon, 30).
spcAtt(lemon, 35).
spcAtt(kemon, 30).
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

/* Healing Tokemon in GYM */
healTokemon :- forall(inventory(Tokemon, Health), procHeal(Tokemon, Health)).
procHeal(Tokemon, Health) :- retract(inventory(Tokemon, Health)), health(Tokemon, X), assertz(inventory(Tokemon, X)).

/* creating Tokemon inventory List */
/*invList :-*/ 

/* Print Available Tokemon */
printAvailTokemon :- write('Available Tokemon : '), nl,
                     forall(inventory(Tokemon, Health), printTokemonName(Tokemon)).
printTokemonName(Tokemon) :- write('- '), write(Tokemon), nl.
 
