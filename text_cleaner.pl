:- module(text_cleaner, [ clean/2, write_header/3, append_file/3, escape_chars/2 ]).
:- use_module(library(readutil)).
:- ensure_loaded('config').

write_header(OutputFile, Module, DB_Size) :-
    open(OutputFile, update, File),
    format(File, ':- module(~s, [ database_size/1, tweet/2 ]).\n', [Module]),
    format(File, 'database_size(~d).\n\n', [DB_Size]),
    close(File).

append_file(Number, Line, OutputFile) :-
    open(OutputFile, append, File),
    format(File, 'tweet(~d, \"~s\").\n', [Number, Line]),
    close(File).

escape_chars(Line, EscapedLine) :-
    split_string(Line, "\\", "", TempA),
    atomics_to_string(TempA, "\\\\", TempB),
    split_string(TempB, "\'", "", TempC),
    atomics_to_string(TempC, "\\\'", TempD),
    split_string(TempD, "\"", "", TempE),
    atomics_to_string(TempE, "\\\"", EscapedLine).

clean_(_, OutputFile, LinesWritten, end_of_file) :-
    split_string(OutputFile, "/.", "", [_,ModuleName|_]),
    write_header(".header.tmp", ModuleName, LinesWritten),

    read_file_to_string(".header.tmp", Header, []),
    read_file_to_string(OutputFile, Tweets, []),
    string_concat(Header, Tweets, AllContents),

    open(OutputFile, write, File),
    write(File, AllContents),
    close(File),
    delete_file(".header.tmp"), !.
clean_(Stream, OutputFile, LinesWritten, _) :-
    read_line_to_string(Stream, Line),
    string_length(Line, Length),
    ( Length > 0 -> (
        escape_chars(Line, EscapedLine),
        append_file(LinesWritten, EscapedLine, OutputFile),
        NewLineNumber is 1 + LinesWritten
    ); NewLineNumber is LinesWritten ),
    clean_(Stream, OutputFile, NewLineNumber, Line).

clean(File, OutputKey) :-
    config(OutputKey, OutputFile),

    open(File, read, Stream),
    clean_(Stream, OutputFile, 0, "").

