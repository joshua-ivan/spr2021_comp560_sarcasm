:- module(sentiment_scoring, [lookup/3, score/3]).

:- consult('sentiword').
lookup(Word, PosScore, NegScore) :-
    adjective(Word, PosScore, NegScore);
    adveb(Word, PosScore, NegScore);
    noun(Word, PosScore, NegScore);
    verb(Word, PosScore, NegScore).
lookup(_, 0, 0).

score_([], PosTotal, PosTotal, NegTotal, NegTotal).
score_([Word|Rest], PosAcc, PosTotal, NegAcc, NegTotal) :-
    lookup(Word, PosScore, NegScore),
    NewPosAcc is PosAcc + PosScore,
    NewNegAcc is NegAcc + NegScore,
    score_(Rest, NewPosAcc, PosTotal, NewNegAcc, NegTotal).

score(X, PosTotal, NegTotal) :-
    score_(X, 0, PosTotal, 0, NegTotal).

hello(X) :- write(X), nl.

