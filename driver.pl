:- module(driver, [ append_csv/5 ]).
:- use_module(library(readutil)).
:- use_module('simple_sarcasm_detector').
:- use_module('sentiment_scoring').
:- ensure_loaded('config').

append_csv(Csv, Text, Pos, Neg, Sarcastic) :-
    open(Csv, append, Results),
    format(Results, '\"~s\",~f,~f,~a\n', [Text, Pos, Neg, Sarcastic]),
    close(Results).

process_tweets_(_, Count, _) :-
    config(random_sample_size, Count), !.
process_tweets_(Database, Count, ResultsCsv) :-
    database_size(DB_size),
    TweetID is random(DB_size),
    tweet(TweetID, Tweet),

    split_string(Tweet, " ", " ", Phrases),
    score(Phrases, Pos, Neg),
    is_sarcasm(Pos, Neg, Sarcastic),
    append_csv(ResultsCsv, Tweet, Pos, Neg, Sarcastic),

    NewCount is Count + 1,
    process_tweets_(Database, NewCount, ResultsCsv).

process_tweets(Database) :-
    use_module(Database),
    config(results_file_name, ResultsCsv),
    process_tweets_(Database, 0, ResultsCsv).

process_text_(_, end_of_file, _) :- !.
process_text_(Stream, _, ResultsCsv) :-
    read_line_to_string(Stream, Line),
    string_length(Line, Length),
    ( Length > 0 -> (
        split_string(Line, " ", " ", Phrases),
        score(Phrases, Pos, Neg),
        is_sarcasm(Pos, Neg, Sarcastic),
        append_csv(ResultsCsv, Line, Pos, Neg, Sarcastic)
    ); true ),
    process_text_(Stream, Line, ResultsCsv).

process_text(File) :-
    open(File, read, Stream),
    config(results_file_name, ResultsCsv),
    process_text_(Stream, "", ResultsCsv).
