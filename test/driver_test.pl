:- use_module('driver').

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

:- end_tests(is_sarcasm).

:- begin_tests(append_csv).

test(expected_output, [
    true(Line == "\"Test Line\",0.000000,0.000000,false"),
    cleanup(delete_file("test.csv"))
]) :-
    append_csv("test.csv", "Test Line", 0.0, 0.0, false),

    open("test.csv", read, Test),
    read_line_to_string(Test, Line).

:- end_tests(append_csv).
