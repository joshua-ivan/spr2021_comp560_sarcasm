:- module(driver, [ append_csv/3 ]).
:- use_module(library(readutil)).
:- ensure_loaded('config').

append_csv(Csv, Text, Sarcastic) :-
    open(Csv, append, Results),
    format(Results, '\"~s\",~a\n', [Text, Sarcastic]),
    close(Results).

process_tweets_(_, _, Count, _) :-
    config(random_sample_size, Count), !.
process_tweets_(Silent, Hits, Count, ResultsCsv) :-
    database_size(DB_size),
    TweetID is random(DB_size),
    tweet(TweetID, Tweet),
    ( \+Silent -> format("~s\n", Tweet) ; true ),

    split_string(Tweet, " ", " ", Phrases),
    ( sarcastic(Phrases)
        -> (IsSarcastic = true, NewHits is Hits + 1)
        ; (IsSarcastic = false, NewHits is Hits)),
    NewCount is Count + 1,
    ( \+Silent -> format("~s, ~d/~d.\n", [IsSarcastic, NewHits, NewCount]) ; true ),

    append_csv(ResultsCsv, Tweet, IsSarcastic),
    process_tweets_(Silent, NewHits, NewCount, ResultsCsv).

process_tweets(Database, Recognizer) :-
    config(silent, Silent),

    use_module(Database),
    ( \+Silent -> format("Database \"~s\" loaded.\n", Database) ; true ),
    use_module(Recognizer),
    ( \+Silent -> format("Recognizer \"~s\" loaded.\n", Recognizer) ; true ),

    config(results_file_name, ResultsCsv),
    process_tweets_(Silent, 0, 0, ResultsCsv).
process_tweets(Database) :-
    process_tweets(Database, "grammar_recognizer").
