:- use_module('driver').

:- begin_tests(append_csv).

test(expected_output, [
    true(Line == "\"Test Line\",false"),
    cleanup(delete_file("test.csv"))
]) :-
    append_csv("test.csv", "Test Line", 'false'),

    open("test.csv", read, Test),
    read_line_to_string(Test, Line).

:- end_tests(append_csv).
