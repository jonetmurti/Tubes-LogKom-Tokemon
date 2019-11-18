/* Game State */
:- dynamic(state/1).

/* Player Location in Map */
:- dynamic(playerloc/2).

/* Healing predicate */
:- dynamic(alreadyHeal/1).

mapsize(10,10).