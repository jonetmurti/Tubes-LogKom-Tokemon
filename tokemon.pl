/* Tokemon DataBase */
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
:- dynamic(nbInv/1).

/* Healing Tokemon in GYM */
healTokemon :- forall(inventory(Tokemon, Health), procHeal(Tokemon, Health)).
procHeal(Tokemon, Health) :- retract(inventory(Tokemon, Health)), health(Tokemon, X), assertz(inventory(Tokemon, X)).

/* creating Tokemon inventory List */
 