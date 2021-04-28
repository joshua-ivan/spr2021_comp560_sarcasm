:- use_module('text_cleaner').

:- begin_tests(append_file).

test(single_line, [
    true(Line == "tweet(0, \"Test Tweet\")."),
    cleanup(delete_file("test.csv"))
]) :-
    append_file(0, "Test Tweet", "test.csv"),

    open("test.csv", read, Test),
    read_line_to_string(Test, Line).

test(multiple_lines, [
    true(File == "tweet(0, \"Test Tweet A\").\ntweet(1, \"Test Tweet B\").\ntweet(2, \"Test Tweet C\").\n"),
    cleanup(delete_file("test.csv"))
]) :-
    append_file(0, "Test Tweet A", "test.csv"),
    append_file(1, "Test Tweet B", "test.csv"),
    append_file(2, "Test Tweet C", "test.csv"),

    read_file_to_string("test.csv", File, []).

:- end_tests(append_file).
