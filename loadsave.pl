:-include('faktaPlayer.pl').
:-include('tokemon.pl').

/*
inventory
nbInv
nLegend
tokemonPos
state
playerLoc
alreadyheal

*/
:- dynamic(sum/1).
sum(0).
addSum :- sum(X), NewX is X + 1.
sumInv(Stream) :- forall(inventory(Tokemon, Health), addSum), sum(Y), X is Y*2, 
                  write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeInvProc(Stream) :- forall(inventory(Tokemon, Health), writeInv(Stream, Tokemon, Health)).
writeInv(Stream, Tokemon, Health) :- write(Stream, Tokemon), write(Stream, '.'), nl(Stream), 
                                     write(Stream, Health), write(Stream, '.'), nl(Stream).

sumNbInv(Stream) :- forall(nbInv(N), addsum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeNbInvProc(Stream) :- forall(nbInv(N), writeNbInv(Stream, N)).
writeNbInv(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumNLegend(Stream) :- forall(nLegend(N), addsum), sum(Y), 
                 write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeNLegendProc(Stream) :- forall(nLegend(N), writeNLegend(Stream, N)).
writeNLegend(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumTokemonPos(Stream) :- forall(tokemonPos(Tokemon, X1, Y1), addsum), sum(Y), X is Y*3
                    write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeTokemonPosProc(Stream) :- forall(tokemonPos(Tokemon, X1, Y1), writeTokemonPos(Stream, Tokemon, X1, Y1)).
writeTokemonPos(Stream, Tokemon, X1, Y1) :- write(Stream, Tokemon), write(Stream, '.'), nl(Stream), 
                                     write(Stream, X1), write(Stream, '.'), nl(Stream),
                                     write(Stream, X1), write(Stream, '.'), nl(Stream).

sumState(Stream) :- forall(state(N), addsum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeStateProc(Stream) :- forall(state(N), writeState(Stream, N)).
writeState(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

sumPlayerLoc(Stream) :- forall(playerLoc(X1, Y1), addSum), sum(Y), X is Y*2, 
                  write(Stream, X), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writePlayerLocProc(Stream) :- forall(playerLoc(X1, Y1), writePlayerLoc(Stream, X1, Y1)).
writePlayerLoc(Stream, X1, Y1) :- write(Stream, X1), write(Stream, '.'), nl(Stream), 
                                  write(Stream, Y1), write(Stream, '.'), nl(Stream).

sumAlreadyHeal(Stream) :- forall(alreadyHeal(N), addsum), sum(Y), 
               write(Stream, Y), write(Stream, '.'), nl(Stream), retract(sum(_)), asserta(sum(0)).
writeAlreadyHealProc(Stream) :- forall(alreadyHeal(N), writeAlreadyHeal(Stream, N)).
writeAlreadyHeal(Stream, N) :- write(Stream, N), write(Stream, '.'), nl(Stream).

save :- \+state(inBattle), open('D:/Kuliah/LogKom/Tubes-Logkom-Tokemon/save.txt', write, Stream), sumInv(Stream), writeInvProc(Stream),
        sumNbInv(Stream), writeNbInvProc(Stream), sumNLegend(Stream), writeNLegendProc(Stream), sumTokemonPos(Stream), writeTokemonPosProc(Stream),
        sumState(Stream), writeStateProc(Stream), sumPlayerLoc(Stream), writePlayerLocProc(Stream), sumAlreadyHeal(Stream), writeAlreadyHealProc(Stream).
save :- state(inBattle), write('You cannot save in battle!!'), nl.