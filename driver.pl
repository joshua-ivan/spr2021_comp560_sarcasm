:- module(driver, [ is_sarcasm/3, append_csv/5 ]).
:- use_module(library(readutil)).
:- use_module('sentiment_scoring').
:- ensure_loaded('config').

is_sarcasm(0, _, false) :- !.
is_sarcasm(_, 0, false) :- !.
is_sarcasm(Pos, Neg, true) :-
    config(sarcasm_score_lower_bound, Lower),
    config(sarcasm_score_upper_bound, Upper),

    Score is (min(Pos, Neg) / max(Pos, Neg)),
    Score >= Lower, Score =< Upper.
is_sarcasm(_, _, false).

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
