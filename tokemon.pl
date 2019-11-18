/* Tokemon DataBase */

/* capture Tokemon */
:- dynamic(currCapture/1).

/* current player tokemon in battle (Tokemon, health) */
:- dynamic(currTokemon/3).
currTokemon :- write('You haven\'t choose your Tokemon').

/* current enemy tokemon in battle (Tokemon, health) */ 
:- dynamic(currEnemy/2).

/* Tokemon Inventory */
/* Inventory  (Tokemon, Health) */
:- dynamic(inventory/2).
/* nbInv  (number), number of tokemon in inventory */
:- dynamic(nbInv/1).

/* Numbers of legendary Tokemon */
:- dynamic(nLegend/1).

/* Legendary */

nama(rahamon, legendary).
nama(logkomon, legendary).
nama(hizmon, legendary).
nama(seamon, normal).
nama(kemon, normal).
nama(jonemon, normal).
nama(mamaLemon, normal).
nama(lemon, normal).
nama(suketmon, normal).

nama(alphamon, normal).
nama(betamon, normal).
nama(gammamon, normal).
nama(deltamon, normal).
nama(epsilonmon, normal).
nama(lambdamon, normal).
nama(pimon, normal).
nama(thetamon, normal).
nama(sigmamon, normal).
nama(omegamon, normal).
nama(rhomon, normal).
nama(psimon, normal).
nama(zetamon, normal).
nama(etamon, normal).
nama(kapamon, normal).
nama(ximon, normal).
nama(taumon, normal).
nama(chimon, normal).

health(hizmon, 1000).
health(logkomon, 1000).
health(rahamon, 1000).
health(seamon, 100).
health(jonemon, 190).
health(mamaLemon, 180).
health(lemon, 110).
health(suketmon, 125).
health(kemon, 120).
health(alphamon, 150).
health(betamon, 110).
health(gammamon, 200).
health(deltamon, 200).
health(epsilonmon, 200).
health(lambdamon, 200).
health(pimon, 200).
health(thetamon, 200).
health(sigmamon, 200).
health(omegamon, 200).
health(rhomon, 200).
health(psimon, 200).
health(zetamon, 200).
health(etamon, 200).
health(kapamon, 200).
health(ximon, 200).
health(taumon, 200).
health(chimon, 200).

type(logkomon, water).
type(seamon, water).
type(mamaLemon, water).
type(zetamon, water).
type(etamon, water).
type(kapamon, water).
type(ximon, water).
type(taumon, water).
type(chimon, water).
type(jonemon, grass).
type(suketmon, grass).
type(hizmon, grass).
type(pimon, grass).
type(thetamon, grass).
type(sigmamon, grass).
type(omegamon, grass).
type(rhomon, grass).
type(psimon, grass).
type(rahamon, fire).
type(lemon, fire).
type(kemon, fire).
type(alphamon, fire).
type(betamon, fire).
type(gammamon, fire).
type(deltamon, fire).
type(epsilonmon, fire).
type(lambdamon, fire).


normalAtt(rahamon, 60).
normalAtt(logkomon, 40).
normalAtt(hizmon, 50).
normalAtt(seamon, 20).
normalAtt(jonemon, 15).
normalAtt(mamaLemon, 15).
normalAtt(lemon, 20).
normalAtt(kemon, 10).
normalAtt(suketmon, 25).
normalAtt(alphamon, 30).
normalAtt(betamon, 30).
normalAtt(gammamon, 30).
normalAtt(deltamon, 30).
normalAtt(epsilonmon, 30).
normalAtt(lambdamon, 30).
normalAtt(pimon, 30).
normalAtt(thetamon, 30).
normalAtt(sigmamon, 30).
normalAtt(omegamon, 30).
normalAtt(rhomon, 30).
normalAtt(psimon, 30).
normalAtt(zetamon, 30).
normalAtt(etamon, 30).
normalAtt(kapamon, 30).
normalAtt(ximon, 30).
normalAtt(taumon, 30).
normalAtt(chimon, 30).

spcAtt(rahamon, 70).
spcAtt(logkomon, 90).
spcAtt(hizmon, 80).
spcAtt(seamon, 40).
spcAtt(jonemon, 25).
spcAtt(mamaLemon, 30).
spcAtt(lemon, 35).
spcAtt(kemon, 30).
spcAtt(suketmon, 40).
spcAtt(alphamon, 80).
spcAtt(betamon, 80).
spcAtt(gammamon, 80).
spcAtt(deltamon, 80).
spcAtt(epsilonmon, 80).
spcAtt(lambdamon, 80).
spcAtt(pimon, 80).
spcAtt(thetamon, 80).
spcAtt(sigmamon, 80).
spcAtt(omegamon, 80).
spcAtt(rhomon, 80).
spcAtt(psimon, 80).
spcAtt(zetamon, 80).
spcAtt(etamon, 80).
spcAtt(kapamon, 80).
spcAtt(ximon, 80).
spcAtt(taumon, 80).
spcAtt(chimon, 80).

/* First Tokemon choose */
firstTokemon(seamon).
firstTokemon(jonemon).
firstTokemon(lemon).

/* Randomize tokemon position in map */
randomTokemonPos(X, Y, Xlist, Ylist) :- repeat, random(1, 11, X), random(1, 11, Y), isMember(X, Xlist, ExistX), isMember(Y, Xlist, ExistY), ExistX == 0, ExistY == 0.

/* Untuk Tokemon menghindari para */
pagarmon(U,V,X,Y) :- \+pagar(U,V),U=X,V=Y.
pagarmon(U,V,X,Y) :- random(1, 11, X1), random(1, 11, Y1),pagarmon(X1,Y1,X,Y).

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
               random(1, 11, X9), random(1, 11, Y9), asserta(tokemonPos(suketmon, X9, Y9)),
               random(1, 11, X10), random(1, 11, Y10), asserta(tokemonPos(alphamon, X10, Y10)),
			   random(1, 11, X11), random(1, 11, Y11), asserta(tokemonPos(betamon, X11, Y11)),
			         random(1, 11, X12), random(1, 11, Y12), asserta(tokemonPos(gammamon, X12, Y12)),
			         random(1, 11, X13), random(1, 11, Y13), asserta(tokemonPos(deltamon, X13, Y13)),
			         random(1, 11, X14), random(1, 11, Y14), asserta(tokemonPos(epsilonmon, X14, Y14)),
			         random(1, 11, X15), random(1, 11, Y15), asserta(tokemonPos(lambdamon, X15, Y15)),
			         random(1, 11, X16), random(1, 11, Y16), asserta(tokemonPos(pimon, X16, Y16)),
			         random(1, 11, X17), random(1, 11, Y17), asserta(tokemonPos(thetamon, X17, Y17)),
               random(1, 11, X18), random(1, 11, Y18), asserta(tokemonPos(sigmamon, X18, Y18)),
               random(1, 11, X19), random(1, 11, Y19), asserta(tokemonPos(omegamon, X19, Y19)),
               random(1, 11, X20), random(1, 11, Y20), asserta(tokemonPos(rhomon, X20, Y20)),
               random(1, 11, X21), random(1, 11, Y21), asserta(tokemonPos(psimon, X21, Y21)),
               random(1, 11, X22), random(1, 11, Y22), asserta(tokemonPos(zetamon, X22, Y22)),
               random(1, 11, X23), random(1, 11, Y23), asserta(tokemonPos(etamon, X23, Y23)),
               random(1, 11, X24), random(1, 11, Y24), asserta(tokemonPos(kapamon, X24, Y24)),
               random(1, 11, X25), random(1, 11, Y25), asserta(tokemonPos(ximon, X25, Y25)),
               random(1, 11, X26), random(1, 11, Y26), asserta(tokemonPos(taumon, X26, Y26)),
               random(1, 11, X27), random(1, 11, Y27), asserta(tokemonPos(chimon, X27,Y27)).

updateTokemonPos :- forall(tokemonPos(Tokemon, X, Y), updatePos(Tokemon, X, Y)).
updatePos(Tokemon, X, Y) :- retract(tokemonPos(Tokemon, X, Y)), random(1, 11, X1), random(1, 11, Y1), assertz(tokemonPos(Tokemon, X1, Y1)).

/* Healing Tokemon in GYM */
healTokemon :- forall(inventory(Tokemon, Health), procHeal(Tokemon, Health)).
procHeal(Tokemon, Health) :- retract(inventory(Tokemon, Health)), health(Tokemon, X), assertz(inventory(Tokemon, X)).

/* creating Tokemon inventory List */
/*invList :-*/ 

/* Print Available Tokemon */
printAvailTokemon :- write('Available Tokemon : '), nl,
                     forall(inventory(Tokemon, Health), printTokemonName(Tokemon)).
printTokemonName(Tokemon) :- write('- '), write(Tokemon), nl.
