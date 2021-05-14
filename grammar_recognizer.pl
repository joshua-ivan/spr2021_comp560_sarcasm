:- module(grammar_recognizer, [ sarcastic/1 ]).
:- ensure_loaded(sarcasmRules).

sarcastic(Phrase) :-
    sarcastic_sentence(Phrase, []).
