:- module(driver, [ append_csv/3 ]).
:- use_module(library(readutil)).
:- ensure_loaded('config').
:- consult([sarcasmRules]).

append_csv(Csv, Text, Sarcastic) :-
    open(Csv, append, Results),
    format(Results, '\"~s\",~a\n', [Text, Sarcastic]),
    close(Results).

process_tweets_(_, _, Count, _) :-
    config(random_sample_size, Count), !.
process_tweets_(PrintTweets, Database, Count, ResultsCsv) :-
    database_size(DB_size),
    TweetID is random(DB_size),
    tweet(TweetID, Tweet),
    ( PrintTweets -> format("~s\n", Tweet) ; true ),

    split_string(Tweet, " ", " ", Phrases),
    ( sarcastic_sentence(Phrases, [])
        -> IsSarcastic = true
        ; IsSarcastic = false),
    append_csv(ResultsCsv, Tweet, IsSarcastic),

    NewCount is Count + 1,
    process_tweets_(PrintTweets, Database, NewCount, ResultsCsv).

process_tweets(Database) :-
    use_module(Database),
    config(results_file_name, ResultsCsv),
    config(print_tweets, PrintTweets),
    process_tweets_(PrintTweets, Database, 0, ResultsCsv).

