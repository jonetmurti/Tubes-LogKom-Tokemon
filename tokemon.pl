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

/* Tokemon Position in Map(changing over time) */
:- dynamic(tokemonPos/3).

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