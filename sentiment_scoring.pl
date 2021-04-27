:- module(sentiment_scoring, [lookup/3, score/3]).

:- ensure_loaded('sentiword').
lookup(Word, PosScore, NegScore) :-
    adjective(Word, PosScore, NegScore);
    adveb(Word, PosScore, NegScore);
    noun(Word, PosScore, NegScore);
    verb(Word, PosScore, NegScore).
lookup(NotInSentiword, 0, 0) :- string(NotInSentiword), !.
lookup(NotAString, 0, 0) :-
    format('WARN: lookup called with nonstring \'~w\'', [NotAString]).

score_([], PosTotal, PosTotal, NegTotal, NegTotal).
score_([Word|Rest], PosAcc, PosTotal, NegAcc, NegTotal) :-
    lookup(Word, PosScore, NegScore),
    NewPosAcc is PosAcc + PosScore,
    NewNegAcc is NegAcc + NegScore,
    score_(Rest, NewPosAcc, PosTotal, NewNegAcc, NegTotal).

score(X, PosTotal, NegTotal) :-
    score_(X, 0, PosTotal, 0, NegTotal).

