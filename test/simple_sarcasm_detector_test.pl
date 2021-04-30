:- use_module('simple_sarcasm_detector').

:- begin_tests(is_sarcasm).

test(valid_scores, [ true(Sarcastic), nondet ]) :-
    is_sarcasm(0.2, 1.0, Sarcastic),
    is_sarcasm(1.0, 0.2, Sarcastic).

test(invalid_scores, [ true(not(Sarcastic)), nondet ]) :-
    is_sarcasm(0.3, 1.0, Sarcastic),
    is_sarcasm(1.0, 0.3, Sarcastic),

    is_sarcasm(0.1, 1.0, Sarcastic),
    is_sarcasm(1.0, 0.1, Sarcastic),

    is_sarcasm(1.0, 1.0, Sarcastic).

test(division_by_zero, [true(not(Sarcastic)) ]) :-
    is_sarcasm(0.0, 1.0, Sarcastic),
    is_sarcasm(1.0, 0.0, Sarcastic),
    is_sarcasm(0.0, 0.0, Sarcastic).

:- end_tests(is_sarcasm).

