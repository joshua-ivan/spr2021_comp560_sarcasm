:- use_module('sentiment_scoring').

:- begin_tests(lookup).

test(not_in_sentiword, []) :-
    lookup("fhqwhgads", Pos, Neg),
    Pos == 0, Neg == 0.
test(given_atom, [ true(X == "WARN: lookup called with nonstring 'fhqwhgads'") ]) :-
    with_output_to(string(X), lookup(fhqwhgads, Pos, Neg)),
    Pos == 0, Neg == 0.

test(adjective, [nondet]) :-
    lookup("abstracted", Pos, Neg),
    Pos == 0.375, Neg == 0.125.
test(adverb, [nondet]) :-
    lookup("intently", Pos, Neg),
    Pos == 0.25, Neg == 0.375.
test(noun, [nondet]) :-
    lookup("concreteness", Pos, Neg),
    Pos == 0.5, Neg == 0.375.
test(verb, [nondet]) :-
    lookup("wake", Pos, Neg),
    Pos == 0.375, Neg == 0.25.

:- end_tests(lookup).

:- begin_tests(score).

test(empty_list, []) :-
    score([], Pos, Neg),
    Pos == 0, Neg == 0.
test(single_word, [nondet]) :-
    score(["pain"], Pos, Neg),
    Pos == 0, Neg == 0.25.
test(multiple_words, [nondet]) :-
    score(["my","life","is","utter","pain"], Pos, Neg),
    Pos == 0.125, Neg == 0.25.

:- end_tests(score).
