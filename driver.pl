:- module(driver, [ is_sarcasm/3, append_csv/5 ]).
:- use_module(library(readutil)).

% stub, to be integrated with sentiment_scoring
score_line_([], PosTotal, PosTotal, NegTotal, NegTotal).
score_line_([_|Rest], PosAcc, PosTotal, NegAcc, NegTotal) :-
    NewPos is PosAcc + 1,
    NewNeg is NegAcc + 1,
    score_line_(Rest, NewPos, PosTotal, NewNeg, NegTotal).
score_line(Line, PosTotal, NegTotal) :-
    score_line_(Line, 0, PosTotal, 0, NegTotal).

is_sarcasm(Pos, Neg, true) :-
    Score is (min(Pos, Neg) / max(Pos, Neg)),
    Score >= 0.175, Score =< 0.225.
is_sarcasm(_, _, false).

append_csv(Csv, Line, Pos, Neg, Sarcastic) :-
    open(Csv, append, Results),
    format(Results, '\"~s\",~f,~f,~a\n', [Line, Pos, Neg, Sarcastic]),
    close(Results).

process_(_, end_of_file) :- !.
process_(Stream, _) :-
    read_line_to_string(Stream, Line),
    string_length(Line, Length),
    ( Length > 0 -> (
        split_string(Line, " ", " ", Phrases),
        score_line(Phrases, Pos, Neg),
        is_sarcasm(Pos, Neg, Sarcastic),
        append_csv("results.csv", Line, Pos, Neg, Sarcastic)
    ); true ),
    process_(Stream, Line).

process_text(File) :-
    open(File, read, Stream),
    process_(Stream, "").
