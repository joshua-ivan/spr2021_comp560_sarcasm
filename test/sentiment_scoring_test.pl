:- ['sentiment_scoring'].

:- begin_tests(lookup).

test(lookup, []) :-
    lookup("Fhqwhgads", Pos, Neg),
    Pos == 0, Neg == 0.

:- end_tests(lookup).
