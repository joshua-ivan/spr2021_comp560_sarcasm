:- use_module('sentiment_scoring').
:- use_module('sentiword').
:- ensure_loaded([determiners]).

posn([X|T],T):-noun(X,A,B),A>0,A>B.
negn([X|T],T):-noun(X,A,B),B>A,B>0.
neun([X|T],T):-noun(X,A,B),B=A,A=0.

posv([X|T],T):-verb(X,A,B),A>0,A>B.
negv([X|T],T):-verb(X,A,B),B>A,B>0.
neuv([X|T],T):-verb(X,A,B),B=A,A=0.

posadj([X|T],T):-adjective(X,A,B),A>0,A>B.
negadj([X|T],T):-adjective(X,A,B),B>A,B>0.
neuadj([X|T],T):-adjective(X,A,B),B=A.

posadv([X|T],T):-adveb(X,A,B),A>0,A>B.
negadv([X|T],T):-adveb(X,A,B),B>A,B>0.
neuadv([X|T],T):-adveb(X,A,B),B=A.

sarcastic_sentence--> posInterjective, negphrases.
sarcastic_sentence--> posInterjective, neuphrases.
sarcastic_sentence--> negInterjective, posphrases.

posInterjective--> posadj.
posInterjective--> pronoun, posv, neun.
posInterjective--> pronoun, posv, posn.

negInterjective--> negadj.
negInterjective--> pronoun, negv, neun.
negInterjective--> pronoun, negv, negn.

posphrases(Phrase, []) :-
    score(Phrase, X, 0),
    X > 0.
neuphrases(Phrase, []) :-
    score(Phrase, 0, 0).
negphrases(Phrase, []) :-
    score(Phrase, 0, X),
    X > 0.

