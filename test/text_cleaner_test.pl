:- use_module('text_cleaner').

:- begin_tests(append_file).

test(single_line, [
    true(File == "tweet(0, \"Test Tweet\").\n"),
    cleanup(delete_file("test.csv"))
]) :-
    append_file(0, "Test Tweet", "test.csv"),

    read_file_to_string("test.csv", File, []).

test(multiple_lines, [
    true(File == "tweet(0, \"Test Tweet A\").\ntweet(1, \"Test Tweet B\").\ntweet(2, \"Test Tweet C\").\n"),
    cleanup(delete_file("test.csv"))
]) :-
    append_file(0, "Test Tweet A", "test.csv"),
    append_file(1, "Test Tweet B", "test.csv"),
    append_file(2, "Test Tweet C", "test.csv"),

    read_file_to_string("test.csv", File, []).

:- end_tests(append_file).

:- begin_tests(escape_chars).

test(no_extra_quotes, [
    true(Line == "Test Line")
]) :-
    escape_chars("Test Line", Line).

test(single_quotes, [
    true(Line == "\\\'Test Line\\\'")
]) :-
    escape_chars("\'Test Line\'", Line).

test(double_quotes, [
    true(Line == "\\\"Test Line\\\"")
]) :-
    escape_chars("\"Test Line\"", Line).

test(backslashes, [
    true(Line == "Test\\\\Line")
]) :-
    escape_chars("Test\\Line", Line).

:- end_tests(escape_chars).

:- begin_tests(write_header).

test(normal_behavior, [
    true(File == ":- module(test, [ database_size/1, tweet/2 ]).\ndatabase_size(10).\n\n"),
    cleanup(delete_file("test.pl"))
]) :-
    write_header("test.pl", "test", 10),
    read_file_to_string("test.pl", File, []).

:- end_tests(write_header).

