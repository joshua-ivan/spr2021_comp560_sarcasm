:- module(simple_sarcasm_detector, [ is_sarcasm/3 ]).
:- ensure_loaded('config').

is_sarcasm(0, 0, false) :- !.
is_sarcasm(0, _, false) :- !.
is_sarcasm(_, 0, false) :- !.
is_sarcasm(Pos, Neg, true) :-
    config(sarcasm_score_lower_bound, Lower),
    config(sarcasm_score_upper_bound, Upper),

    Score is (min(Pos, Neg) / max(Pos, Neg)),
    Score >= Lower, Score =< Upper.
is_sarcasm(_, _, false).

