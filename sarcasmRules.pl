:- consult([sentiword,determiners]).

positive(A, B) :- A > 0, A > B.
negative(A, B) :- B > A, B > 0.
neutral(A, B) :- A == 0, B == 0.

lookup(Pos, X, A, B, Phrase, Remaining) :-
    call(Pos, X, A, B),
    Phrase == [X | Remaining].
lookup(Pos, NotInSentiword, 0, 0) :-
    format('WARN: \'~w(~w)\' not present in Sentiword\n', [Pos, NotInSentiword]).

n(X, Comparator, Phrase, Remaining):-
    lookup(noun, X, A, B, Phrase, Remaining),
    call(Comparator, A, B).
v(X, Comparator, Phrase, Remaining):-
    lookup(verb, X, A, B, Phrase, Remaining),
    call(Comparator, A, B).
adj(X, Comparator, Phrase, Remaining):-
    lookup(adjective, X, A, B, Phrase, Remaining),
    call(Comparator, A, B).
adv(X, Comparator, Phrase, Remaining):-
    lookup(adverb, X, A, B, Phrase, Remaining),
    call(Comparator, A, B).

sarcastic_sentence--> sarcasm.

sarcasm--> negphrases, posphrases.
sarcasm--> posphrases, negphrases.
sarcasm--> neuphrases, posphrases.

sarcasm--> negphrases, conj, posphrases.
sarcasm--> posphrases, conj, negphrases.
sarcasm--> neuphrases, conj, posphrases.

sarcasm--> conj, negphrases, posphrases.
sarcasm--> conj, posphrases, negphrases.
sarcasm--> conj, neuphrases, posphrases.

posphrases--> posNP, posVP.
posphrases--> posVP.

neuphrases--> neuNP, neuVP.

negphrases--> negNP, negVP.
negphrases--> negNP.
negphrases--> adj(_,negative), negNP.
negphrases--> adj(_,negative), posNP.
negphrases--> adj(_,negative), neuNP.
negphrases--> adj(_,negative), negNP, negVP.
negphrases--> adj(_,negative), neuNP, negVP.
negphrases--> adj(_,negative), posNP, negVP.
negphrases--> negVP.

/************************************noun phrases***********************************/

posNP--> n(_,positive).
posNP--> det, n(_,positive).
posNP--> adj(_,positive), n(_, positive).
posNP--> adj(_,positive), n(_, neutral).
posNP--> det, adj(_,positive), n(_, positive).
posNP--> det, adj(_,positive), n(_, neutral).

neuNP--> pronoun.
neuNP--> n(_,neutral).
neuNP--> det, n(_,neutral).
neuNP--> adj(_,neutral), n(_,neutral).
neuNP--> det, adj(_,neutral), n(_,neutral).

negNP--> n(_,negative).
negNP--> det, n(_,negative).
negNP--> det, adj(_,negative), n(_,neutral).
negNP--> adj(_,negative), n(_,neutral).
negNP--> det, adj(_,negative), n(_,negative).
negNP--> adj(_,negative), n(_,negative).

/***********************************verb phrases**************************************/

posVP--> v(_,positive).
posVP--> pronoun, v(_,positive).
posVP--> adj(_,positive), v(_,neutral).
posVP--> adj(_,positive), v(_,positive).
posVP--> v(_,positive), adj(_,neutral).
posVP--> v(_,positive), adj(_,positive).
posVP--> adv(_,positive), v(_,positive).
posVP--> adv(_,neutral), v(_,positive).
posVP--> adv(_,positive), v(_,neutral).
posVP--> pronoun, adv(_,positive), v(_,positive).
posVP--> pronoun, adv(_,neutral), v(_,positive).
posVP--> pronoun, adv(_,positive), v(_,neutral).

neuVP--> v(_,neutral).
neuVP--> pronoun, v(_,neutral).
neuVP--> adj(_,neutral), v(_,neutral).
neuVP--> v(_,neutral), adv(_,neutral).
neuVP--> adv(neutral), v(neutral).
neuVP--> pronoun, adv(neutral), v(neutral).

negVP--> v(_,negative).
negVP--> pronoun, v(_,negative).
negVP--> adj(_,negative), v(_,neutral).
negVP--> adj(_,negative), v(_,negative).
negVP--> v(_,negative), adj(_,neutral).
negVP--> v(_,negative), adj(_,negative).
negVP--> adv(_,negative), v(_,negative).
negVP--> adv(_,neutral), v(_,negative).
negVP--> adv(_,negative), v(_,neutral).
negVP--> pronoun, adv(_.negative), v(_,negative).
negVP--> pronoun, adv(_,neutral), v(_,negative).
negVP--> pronoun, adv(_,negative), v(_,neutral).
negVP--> adj(_,negative), v(_,positive).
negVP--> v(_,negative), adj(_,positive).
negVP--> adv(_,positive), v(_,negative).
negVP--> adv(_,negative), v(_,positive).
negVP--> pronoun, adv(_,positive), v(_,negative).
negVP--> pronoun, adv(_,negative), v(_,positive).

