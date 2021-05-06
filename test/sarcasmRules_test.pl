:- consult(sarcasmRules).

:- begin_tests(comparators).

test(positive, []) :-
    positive(1, 0),
    \+ positive(0, 1),
    \+ positive(0, 0).

test(negative, []) :-
    negative(0, 1),
    \+ negative(1, 0),
    \+ negative(0, 0).

test(neutral, []) :-
    neutral(0, 0),
    \+ neutral(1, 0),
    \+ neutral(0, 1).

:- end_tests(comparators).

:- begin_tests(lookup).

test(lookup, [nondet]) :-
    lookup(noun, "coordination", NounA, NounB, ["coordination"], []),
    NounA == 0.5, NounB == 0,
    lookup(verb, "work", VerbA, VerbB, ["work"], []),
    VerbA == 0.375, VerbB == 0,
    lookup(adjective, "aggravated", AdjA, AdjB, ["aggravated"], []),
    AdjA == 0, AdjB == 0.5,
    lookup(adverb, "about", AdvA, AdvB, ["about"], []),
    AdvA == 0, AdvB == 0.

test(lookup_invalid_pos,[ true(X == "WARN: \'made_up_pos(test)\' not present in Sentiword\n") ]) :-
    with_output_to(string(X), lookup(made_up_pos, "test", MadeUpA, MadeUpB)),
    MadeUpA == 0, MadeUpB == 0.

test(lookup_invalid_word,[ true(X == "WARN: \'noun(fhegahds)\' not present in Sentiword\n") ]) :-
    with_output_to(string(X), lookup(noun, "fhegahds", MadeUpC, MadeUpD)),
    MadeUpC == 0, MadeUpD == 0.

:- end_tests(lookup).

:- begin_tests(parts_of_speech).

test(n, [nondet]) :-
    n("coordination", positive, ["coordination"], []),
    n("tragedy", negative, ["tragedy"], []),
    n("dance", neutral, ["dance"], []).

test(v, [nondet]) :-
    v("work", positive, ["work"], []),
    v("abandon", negative, ["abandon"], []),
    v("accumulate", neutral, ["accumulate"], []).

test(adj, [nondet]) :-
    adj("absolute", positive, ["absolute"], []),
    adj("aggravated", negative, ["aggravated"], []),
    adj("absorbent", neutral, ["absorbent"], []).

test(adv, [nondet]) :-
    adv("a_great_deal", positive, ["a_great_deal"], []),
    adv("ad_infinitum", negative, ["ad_infinitum"], []),
    adv("about", neutral, ["about"], []).

:- end_tests(parts_of_speech).
