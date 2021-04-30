:- module(driver, [ append_csv/5 ]).
:- use_module(library(readutil)).
:- use_module('simple_sarcasm_detector').
:- use_module('sentiment_scoring').
:- ensure_loaded('config').

append_csv(Csv, Line, Pos, Neg, Sarcastic) :-
    open(Csv, append, Results),
    format(Results, '\"~s\",~f,~f,~a\n', [Line, Pos, Neg, Sarcastic]),
    close(Results).

process_(_, end_of_file) :- !.
process_(Stream, _) :-
    config(results_file_name, ResultsCsv),

    read_line_to_string(Stream, Line),
    string_length(Line, Length),
    ( Length > 0 -> (
        split_string(Line, " ", " ", Phrases),
        score(Phrases, Pos, Neg),
        is_sarcasm(Pos, Neg, Sarcastic),
        append_csv(ResultsCsv, Line, Pos, Neg, Sarcastic)
    ); true ),
    process_(Stream, Line).

process_text(File) :-
    open(File, read, Stream),
    process_(Stream, "").
