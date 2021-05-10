:- module(sentiment_scoring, [lookup/3, score/3]).

:- ensure_loaded('sentiword').
lookup(Word, PosScore, NegScore) :-
    adjective(Word, PosScore, NegScore);
    adverb(Word, PosScore, NegScore);
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

cnt_np([], PosCount, PosCount, NegCount, NegCount).
cnt_np([Word|Rest], PosAcc, PosCount, NegAcc, NegCount):-
    lookup(Word, PosScore, NegScore),
    PosScore > NegScore,
    NewPosAcc is PosAcc + 1,
    cnt_np(Rest, NewPosAcc, PosCount, NegAcc, NegCount).
cnt_np([Word|Rest], PosAcc, PosCount, NegAcc, NegCount):-
    lookup(Word, PosScore, NegScore),
    PosScore < NegScore,
    NewNegAcc is NegAcc + 1,
    cnt_np(Rest, PosAcc, PosCount, NewNegAcc, NegCount).
cnt_np([Word|Rest], PosAcc, PosCount, NegAcc, NegCount):-
    lookup(Word, PosScore, NegScore),
    PosScore =:= NegScore,
    not(PosScore =:= 0),
    NewPosAcc is PosAcc + 1,
    NewNegAcc is NegAcc + 1,
    cnt_np(Rest, NewPosAcc, PosCount, NewNegAcc, NegCount).
cnt_np([Word|Rest], PosAcc, PosCount, NegAcc, NegCount):-
    lookup(Word, PosScore, NegScore),
    PosScore =:= NegScore,
    PosScore =:= 0,
    cnt_np(Rest, PosAcc, PosCount, NegAcc, NegCount).

count_pos_neg(X, PosCount, NegCount):-
    cnt_np(X, 0, PosCount, 0, NegCount).

pos_neg_ratio(Sentence, PosRatio, NegRatio):-
    length(Sentence, Len),
    count_pos_neg(Sentence, PosScore, NegScore),
    PosRatio is PosScore / Len,
    NegRatio is NegScore / Len.
