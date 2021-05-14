:- module(simple_recognizer, [ sarcastic/1 ]).
:- use_module(simple_sarcasm_detector).
:- use_module(sentiment_scoring).

sarcastic(Phrase) :-
    score(Phrase, Pos, Neg),
    is_sarcasm(Pos, Neg, IsSarcastic),
    IsSarcastic.

