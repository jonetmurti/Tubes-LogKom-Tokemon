:-include('faktaPlayer.pl').
:-include('tokemon.pl').

/*
inventory
nbInv
nLegend
tokemonPos
state
playerloc
alreadyheal

*/
:- dynamic(sum/1).
sum(0).
addSum :- sum(X), NewX is X + 1, retract(sum(X)), asserta(sum(NewX)).
sumInv(Stream) :- forall(inventory(Tokemon, Health), addSum), sum(Y), X is Y, 
                  write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeInvProc(Stream) :- forall(inventory(Tokemon, Health), writeInv(Stream, Tokemon, Health)).
writeInv(Stream, Tokemon, Health) :- write(Stream, Tokemon), write(Stream, '.'), nl(Stream), 
                                     write(Stream, Health), write(Stream, '.'), nl(Stream).

sumNbInv(Stream) :- forall(nbInv(N), addSum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeNbInvProc(Stream) :- forall(nbInv(N), writeNbInv(Stream, N)).
writeNbInv(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumNLegend(Stream) :- forall(nLegend(N), addSum), sum(Y), 
                 write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeNLegendProc(Stream) :- forall(nLegend(N), writeNLegend(Stream, N)).
writeNLegend(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumTokemonPos(Stream) :- forall(tokemonPos(Tokemon, X1, Y1), addSum), sum(Y), X is Y,
                    write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeTokemonPosProc(Stream) :- forall(tokemonPos(Tokemon, X1, Y1), writeTokemonPos(Stream, Tokemon, X1, Y1)).
writeTokemonPos(Stream, Tokemon, X1, Y1) :- write(Stream, Tokemon), write(Stream, '.'), nl(Stream), 
                                     write(Stream, X1), write(Stream, '.'), nl(Stream),
                                     write(Stream, X1), write(Stream, '.'), nl(Stream).

sumState(Stream) :- forall(state(N), addSum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeStateProc(Stream) :- forall(state(N), writeState(Stream, N)).
writeState(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumPlayerLoc(Stream) :- forall(playerloc(X1, Y1), addSum), sum(Y), X is Y, 
                  write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writePlayerLocProc(Stream) :- forall(playerloc(X1, Y1), writePlayerLoc(Stream, X1, Y1)).
writePlayerLoc(Stream, X1, Y1) :- write(Stream, X1), write(Stream, '.'), nl(Stream), 
                                  write(Stream, Y1), write(Stream, '.'), nl(Stream).

sumAlreadyHeal(Stream) :- forall(alreadyHeal(N), addSum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeAlreadyHealProc(Stream) :- forall(alreadyHeal(N), writeAlreadyHeal(Stream, N)).
writeAlreadyHeal(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

save :- \+state(inBattle), open('D:/Kuliah/LogKom/Tubes-Logkom-Tokemon/new.txt', write, Stream), sumInv(Stream), writeInvProc(Stream),
        sumNbInv(Stream), writeNbInvProc(Stream), sumNLegend(Stream), writeNLegendProc(Stream), sumTokemonPos(Stream), writeTokemonPosProc(Stream),
        sumState(Stream), writeStateProc(Stream), sumPlayerLoc(Stream), writePlayerLocProc(Stream), sumAlreadyHeal(Stream), writeAlreadyHealProc(Stream), close(Stream), write('Save success!'), nl, !.
save :- state(inBattle), write('You cannot save in battle!!'), nl, !.


retractAll :- forall(tokemonPos(X, Y, Z), retract(tokemonPos(X, Y, Z))), forall(state(X1), retract(state(X1))), forall(currTokemon(X2,Y2,Z2), retract(currTokemon(X2,Y2,Z2))),
        forall(currEnemy(X3,Y3), retract(currEnemy(X3,Y3))), forall(inventory(X4, Y4), retract(inventory(X4, Y4))), forall(nbInv(X5), retract(nbInv(X5))), 
        forall(playerloc(X6,Y6), retract(playerloc(X6,Y6))), forall(alreadyHeal(X7), retract(alreadyHeal(X7))), forall(nLegend(X8), retract(nLegend(X8))).

readInvProc(Stream) :- read(Stream, N), forall(between(1, N, X), readInv(Stream)).
readInv(Stream) :- read(Stream, Tokemon), read(Stream, Health), assertz(inventory(Tokemon, Health)).

readNbInvProc(Stream) :- read(Stream, N), forall(between(1, N, X), readNbInv(Stream)).
readNbInv(Stream) :- read(Stream, N1), assertz(nbInv(N1)).

readNLegendProc(Stream) :- read(Stream, N), forall(between(1, N, X), readNLegend(Stream)).
readNLegend(Stream) :- read(Stream, N1), assertz(nLegend(N1)).

readTokemonPosProc(Stream) :- read(Stream, N), forall(between(1, N, X), readTokemonPos(Stream)).
readTokemonPos(Stream) :- read(Stream, Tokemon), read(Stream, X), read(Stream, Y), assertz(tokemonPos(Tokemon, X, Y)).

readStateProc(Stream) :- read(Stream, N), forall(between(1, N, X), readState(Stream)).
readState(Stream) :- read(Stream, N1), assertz(state(N1)).

readPlayerLocProc(Stream) :- read(Stream, N), forall(between(1, N, X), readPlayerLoc(Stream)).
readPlayerLoc(Stream) :- read(Stream, X), read(Stream, Y), assertz(playerloc(X, Y)).

readAlreadyHealProc(Stream) :- read(Stream, N), forall(between(1, N, X), readAlreadyHeal(Stream)).
readAlreadyHeal(Stream) :- read(Stream, N1), assertz(alreadyHeal(N1)).

load :- open('D:/Kuliah/LogKom/Tubes-Logkom-Tokemon/new.txt', read, Stream), retractAll, readInvProc(Stream), readNbInvProc(Stream),
        readNLegendProc(Stream), readTokemonPosProc(Stream), readStateProc(Stream), readPlayerLocProc(Stream), readAlreadyHealProc(Stream), close(Stream),
        write('Load success!'), nl, !.