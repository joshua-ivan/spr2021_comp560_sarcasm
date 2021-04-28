:- module(text_cleaner, [ clean/2, append_file/3 ]).
:- use_module(library(readutil)).
:- ensure_loaded('config').

append_file(Number, Line, OutputFile) :-
    open(OutputFile, append, File),
    format(File, 'tweet(~d, \"~s\").\n', [Number, Line]),
    close(File).

clean_(_, _, _, end_of_file) :- !.
clean_(Stream, OutputFile, LinesWritten, _) :-
    read_line_to_string(Stream, Line),
    string_length(Line, Length),
    ( Length > 0 -> (
        append_file(LinesWritten, Line, OutputFile),
        NewLineNumber is 1 + LinesWritten
    ); NewLineNumber is LinesWritten ),
    clean_(Stream, OutputFile, NewLineNumber, Line).

clean(File, OutputKey) :-
    config(OutputKey, OutputFile),

    open(File, read, Stream),
    clean_(Stream, OutputFile, 0, "").

