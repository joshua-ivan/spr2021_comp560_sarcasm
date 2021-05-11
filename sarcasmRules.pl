
:- consult([sentiword,determiners]).

posn([X|T],T):-noun(X,A,B),A>0, A>B.
negn([X|T],T):-noun(X,A,B),B>A,B>0.
neun([X|T],T):-noun(X,A,B),B=A,A=0.

posv([X|T],T):-verb(X,A,B),A>0, A>B.
negv([X|T],T):-verb(X,A,B),B>A,B>0.
neuv([X|T],T):-verb(X,A,B),B=A,A=0.

posadj([X|T],T):-adjective(X,A,B),A>0, A>B.
negadj([X|T],T):-adjective(X,A,B),B>A,B>0.
neuadj([X|T],T):-adjective(X,A,B),B=A.

posadv([X|T],T):-adverb(X,A,B),A>0, A>B.
negadv([X|T],T):-adverb(X,A,B),B>A,B>0.
neuadv([X|T],T):-adverb(X,A,B),B=A.

nonword([X|T], T):- not(noun(X, _, _)), not(verb(X, _, _)), not(adjective(X, _, _)), not(adverb(X, _, _)), !.

sarcastic_sentence--> sarcasm.
sarcastic_sentence--> sarcasm, sentence.
sarcastic_sentence--> sarcasm,sentence,sentence.
sarcastic_sentence--> sarcasm,sentence,sentence,sentence.
sarcastic_sentence--> sentence,sarcasm.
sarcastic_sentence--> sentence,sentence,sarcasm.
sarcastic_sentence--> sentence,sarcasm,sentence.
sarcastic_sentence--> sentence,sarcasm,sentence,sentence.
sarcastic_sentence--> sentence,sentence,sarcasm,sentence.
sarcastic_sentence--> sentence,sentence,sentence,sarcasm.

sentence-->neuphrases.
sentence--> nonword.
sentence-->conj,neuphrases,neuphrases.
sentence-->conj,conj,neuphrases,neuphrases.
sentence-->conj,conj,conj,neuphrases,neuphrases.
sentence-->neuphrases,neuphrases.
sentence-->neuphrases,conj,neuphrases.
sentence-->neuphrases,conj,conj,neuphrases.
sentence-->neuphrases,conj,conj,conj,neuphrases.
sentence-->posphrases.
sentence-->conj,posphrases,posphrases.
sentence-->conj,conj,posphrases,posphrases.
sentence-->conj,conj,conj,posphrases,posphrases.
sentence-->posphrases,posphrases.
sentence-->posphrases,conj,posphrases.
sentence-->posphrases,conj,conj,posphrases.
sentence-->posphrases,conj,conj,conj,posphrases.
sentence-->negphrases.
sentence-->conj,negphrases,negphrases.
sentence-->conj,conj,negphrases,negphrases.
sentence-->conj,conj,conj,negphrases,negphrases.
sentence-->negphrases,negphrases.
sentence-->negphrases,conj,negphrases.
sentence-->negphrases,conj,conj,negphrases.
sentence-->negphrases,conj,conj,negphrases.

negsentence--> negphrases, neuphrases.
negsentence--> neuphrases, negphrases.
negsentence--> negphrases, negphrases.
negsentence--> negphrases,conj, neuphrases.
negsentence--> neuphrases,conj, negphrases.
negsentence--> negphrases,conj, negphrases.
negsentence--> negphrases,conj,conj, neuphrases.
negsentence--> neuphrases,conj,conj, negphrases.
negsentence--> negphrases,conj,conj, negphrases.
negsentence--> negphrases,conj,conj,conj, neuphrases.
negsentence--> neuphrases,conj,conj,conj, negphrases.
negsentence--> negphrases,conj,conj,conj, negphrases.
negsentence--> conj, negphrases, neuphrases.
negsentence--> conj, neuphrases, negphrases.
negsentence--> conj, negphrases, negphrases.
negsentence--> conj, conj, negphrases, neuphrases.
negsentence--> conj, conj, neuphrases, negphrases.
negsentence--> conj, conj, negphrases, negphrases.
negsentence--> conj, conj, conj, negphrases, neuphrases.
negsentence--> conj, conj, conj, neuphrases, negphrases.
negsentence--> conj, conj, conj, negphrases, negphrases.

possentence--> posphrases, neuphrases.
possentence--> neuphrases, posphrases.
possentence--> posphrases, posphrases.
possentence--> posphrases,conj, neuphrases.
possentence--> neuphrases,conj, posphrases.
possentence--> posphrases,conj, posphrases.
possentence--> posphrases,conj,conj, neuphrases.
possentence--> neuphrases,conj,conj, posphrases.
possentence--> posphrases,conj,conj, posphrases.
possentence--> posphrases,conj,conj,conj, neuphrases.
possentence--> neuphrases,conj,conj,conj, posphrases.
possentence--> posphrases,conj,conj,conj, posphrases.
possentence--> conj, posphrases, neuphrases.
possentence--> conj, neuphrases, posphrases.
possentence--> conj, posphrases, posphrases.
possentence--> conj,conj, posphrases, neuphrases.
possentence--> conj,conj, neuphrases, posphrases.
possentence--> conj,conj, posphrases, posphrases.
possentence--> conj,conj,conj, posphrases, neuphrases.
possentence--> conj,conj,conj, neuphrases, posphrases.
possentence--> conj,conj,conj, posphrases, posphrases.

sarcasm--> posphrases, negphrases.
sarcasm--> negphrases, posphrases.
sarcasm--> neuphrases, posphrases.

sarcasm-->possentence,negsentence.
sarcasm-->negsentence,possentence.

sarcasm--> negphrases, conj, posphrases.
sarcasm--> posphrases, conj, negphrases.
sarcasm--> negphrases, conj, posphrases.
sarcasm--> negphrases, conj,conj, posphrases.
sarcasm--> posphrases, conj,conj, negphrases.
sarcasm--> negphrases, conj,conj, posphrases.
sarcasm--> negphrases, conj,conj,conj, posphrases.
sarcasm--> posphrases, conj,conj,conj, negphrases.
sarcasm--> negphrases, conj,conj,conj, posphrases.
sarcasm--> conj, negphrases, posphrases.
sarcasm--> conj, posphrases, negphrases.
sarcasm--> conj, neuphrases, posphrases.
sarcasm--> conj,conj, negphrases, posphrases.
sarcasm--> conj,conj, posphrases, negphrases.
sarcasm--> conj,conj, neuphrases, posphrases.
sarcasm--> conj,conj,conj, negphrases, posphrases.
sarcasm--> conj,conj,conj, posphrases, negphrases.
sarcasm--> conj,conj,conj, neuphrases, posphrases.

posphrases--> posNP.
posphrases-->posVP.
posphrases--> posNP, posVP.
posphrases--> posVP, posNP.

neuphrases--> neuNP.
neuphrases--> neuNP, neuNP.
neuphrases--> neuVP.
neuphrases--> neuVP, neuVP.
neuphrases--> neuNP, neuVP.
neuphrases--> neuVP, neuNP.
neuphrases--> neuadj, neuNP.
neuphrases--> neuadj, neuNP, neuVP.

negphrases--> negNP.
negphrases--> negNP, negVP.
negphrases--> negadj, negNP.
negphrases--> negadj, posNP.
negphrases--> negadj, neuNP.
negphrases--> negadj, negNP, negVP.
negphrases--> negadj, neuNP, negVP.
negphrases--> negadj, posNP, negVP.
negphrases--> negVP.

/************************************noun phrases***********************************/

posNP-->posn.
posNP--> pronoun, posn.
posNP--> pronoun,pronoun, posn.
posNP-->det, posn.
posNP-->det,det, posn.

posNP-->posadj, posn.
posNP-->posadj, neun.
posNP-->det, posadj, posn.
posNP-->det, posadj, neun.
posNP-->det,det, posadj, posn.
posNP-->det,det, posadj, neun.


posNP-->prep, posn.
posNP-->prep, pronoun, posn.
posNP-->prep, pronoun,pronoun, posn.
posNP-->prep, det, posn.
posNP-->prep, det,det, posn.
posNP-->prep, posadj, posn.
posNP-->prep, posadj, neun.
posNP-->prep, det, posadj, posn.
posNP-->prep, det, posadj, neun.
posNP-->prep, det,det, posadj, posn.
posNP-->prep, det,det, posadj, neun.
posNP-->prep,prep, posn.
posNP-->prep,prep, pronoun, posn.
posNP-->prep,prep, pronoun,pronoun, posn.
posNP-->prep,prep, det, posn.
posNP-->prep,prep, det,det, posn.
posNP-->prep,prep, posadj, posn.
posNP-->prep,prep, posadj, neun.
posNP-->prep,prep, det, posadj, posn.
posNP-->prep,prep, det, posadj, neun.
posNP-->prep,prep, det,det, posadj, posn.
posNP-->prep,prep, det,det, posadj, neun.
posNP-->prep,prep,prep, posn.
posNP-->prep,prep,prep, pronoun, posn.
posNP-->prep,prep,prep, pronoun,pronoun, posn.
posNP-->prep,prep,prep, det, posn.
posNP-->prep,prep,prep, det,det, posn.
posNP-->prep,prep,prep, posadj, posn.
posNP-->prep,prep,prep, posadj, neun.
posNP-->prep,prep,prep, det, posadj, posn.
posNP-->prep,prep,prep, det, posadj, neun.
posNP-->prep,prep,prep, det,det, posadj, posn.
posNP-->prep,prep,prep, det,det, posadj, neun.

neuNP--> pronoun.
neuNP--> pronoun, neun.
neuNP--> pronoun,pronoun.
neuNP--> pronoun,pronoun, neun.

neuNP--> neun.
neuNP--> det, neun.
neuNP--> det,det, neun.

neuNP--> neuadj, neun.
neuNP--> det, neuadj, neun.
neuNP--> det,det, neuadj, neun.
neuNP-->prep, pronoun.
neuNP-->prep, pronoun, neun.
neuNP-->prep, pronoun,pronoun.
neuNP-->prep, pronoun,pronoun, neun.
neuNP-->prep,prep, pronoun.
neuNP-->prep,prep, pronoun, neun.
neuNP-->prep,prep, pronoun,pronoun.
neuNP-->prep,prep, pronoun,pronoun, neun.
neuNP-->prep,prep,prep, pronoun.
neuNP-->prep,prep,prep, pronoun, neun.
neuNP-->prep,prep,prep, pronoun,pronoun.
neuNP-->prep,prep,prep, pronoun,pronoun, neun.
neuNP-->prep, neun.
neuNP-->prep, det, neun.
neuNP-->prep, det,det, neun.
neuNP-->prep, neuadj, neun.
neuNP-->prep, det, neuadj, neun.
neuNP-->prep, det,det, neuadj, neun.
neuNP-->prep,prep, neun.
neuNP-->prep,prep, det, neun.
neuNP-->prep,prep, det,det, neun.
neuNP-->prep,prep, neuadj, neun.
neuNP-->prep,prep, det, neuadj, neun.
neuNP-->prep,prep, det,det, neuadj, neun.
neuNP-->prep,prep,prep, neun.
neuNP-->prep,prep,prep, det, neun.
neuNP-->prep,prep,prep, det,det, neun.
neuNP-->prep,prep,prep, neuadj, neun.
neuNP-->prep,prep,prep, det, neuadj, neun.
neuNP-->prep,prep,prep, det,det, neuadj, neun.

negNP--> negn.
negNP--> pronoun, negn.
negNP--> pronoun,pronoun, negn.
negNP--> det, negn.
negNP--> det, negadj, neun.
negNP--> det,det, negn.
negNP--> det,det, negadj, neun.
negNP--> negadj, neun.
negNP--> det, negadj, negn.
negNP--> det,det, negadj, negn.
negNP--> negadj, negn.
negNP-->prep, negn.
negNP-->prep, pronoun, negn.
negNP-->prep, pronoun, pronoun, negn.
negNP-->prep, det, negn.
negNP-->prep, det, negadj, neun.
negNP-->prep, det,det, negn.
negNP-->prep, det,det, negadj, neun.
negNP-->prep, negadj, neun.
negNP-->prep, det, negadj, negn.
negNP-->prep, det,det, negadj, negn.
negNP-->prep, negadj, negn.
negNP-->prep,prep, negn.
negNP-->prep,prep, pronoun, negn.
negNP-->prep,prep, pronoun, pronoun, negn.
negNP-->prep,prep, det, negn.
negNP-->prep,prep, det, negadj, neun.
negNP-->prep,prep, det,det, negn.
negNP-->prep,prep, det,det, negadj, neun.
negNP-->prep,prep, negadj, neun.
negNP-->prep,prep, det, negadj, negn.
negNP-->prep,prep, det,det, negadj, negn.
negNP-->prep,prep, negadj, negn.
negNP-->prep,prep,prep, negn.
negNP-->prep,prep,prep, pronoun, negn.
negNP-->prep,prep,prep, pronoun, pronoun, negn.
negNP-->prep,prep,prep, det, negn.
negNP-->prep,prep,prep, det, negadj, neun.
negNP-->prep,prep,prep, det,det, negn.
negNP-->prep,prep,prep, det,det, negadj, neun.
negNP-->prep,prep,prep, negadj, neun.
negNP-->prep,prep,prep, det, negadj, negn.
negNP-->prep,prep,prep, det,det, negadj, negn.
negNP-->prep,prep,prep, negadj, negn.

/***********************************verb phrases**************************************/

posVP--> pronoun, posv.
posVP--> pronoun,pronoun, posv.
posVP--> posv.
posVP--> posadj, neuv.
posVP--> posadj, posv.
posVP--> posv, neuadj.
posVP--> posv, posadj.
posVP--> posadv, posv.
posVP--> posv, posadv.
posVP--> neuadv, posv.
posVP--> posadv, neuv.
posVP--> neuv,posadv.
posVP--> pronoun, posadv, posv.
posVP--> pronoun, posv, posadv.
posVP--> pronoun, neuadv, posv.
posVP--> pronoun, posv, neuadv.
posVP--> pronoun, posadv, neuv.
posVP--> pronoun, neuv, posadv.
posVP--> pronoun,pronoun, posadv, posv.
posVP--> pronoun,pronoun, posv, posadv.
posVP--> pronoun,pronoun, neuadv, posv.
posVP--> pronoun,pronoun, posv, neuadv.
posVP--> pronoun,pronoun, posadv, neuv.
posVP--> pronoun,pronoun, neuv, posadv.

neuVP--> neuv.
neuVP--> pronoun, neuv.
neuVP--> pronoun,pronoun, neuv.
neuVP--> neuadj, neuv.
neuVP--> neuv, neuadv.
neuVP--> neuadv, neuv.
neuVP--> pronoun, neuadv, neuv.
neuVP--> pronoun, neuv, neuadv.
neuVP--> pronoun,pronoun, neuadv, neuv.
neuVP--> pronoun,pronoun, neuv, neuadv.

negVP-->  negv.
negVP--> pronoun, negv.
negVP--> pronoun,pronoun, negv.
negVP--> negadj, neuv.
negVP--> negadj, negv.
negVP--> negv, neuadj.
negVP--> negv, negadj.
negVP--> negadv, negv.
negVP--> negv, negadv.
negVP--> neuadv, negv.
negVP--> negv, neuadv.
negVP--> negadv, neuv.
negVP--> neuv, negadv.
negVP--> pronoun, negadv, negv.
negVP--> pronoun, negv, negadv.
negVP--> pronoun, neuadv, negv.
negVP--> pronoun, negv, neuadv.
negVP--> pronoun, negadv, neuv.
negVP--> pronoun, neuv,negadv.
negVP--> pronoun,pronoun, negadv, negv.
negVP--> pronoun,pronoun, negv, negadv.
negVP--> pronoun,pronoun, neuadv, negv.
negVP--> pronoun,pronoun, negv, neuadv.
negVP--> pronoun,pronoun, negadv, neuv.
negVP--> pronoun,pronoun, neuv,negadv.
negVP--> negadj, posv.
negVP--> negv, posadj.
negVP--> posadv, negv.
negVP--> negv, posadv.
negVP--> negadv, posv.
negVP--> posv,negadv.
negVP--> pronoun, posadv, negv.
negVP--> pronoun, negv, posadv.
negVP--> pronoun, negadv, posv.
negVP--> pronoun, posv,negadv.
negVP--> pronoun,pronoun, posadv, negv.
negVP--> pronoun,pronoun, negv, posadv.
negVP--> pronoun,pronoun, negadv, posv.
negVP--> pronoun,pronoun, posv,negadv.

