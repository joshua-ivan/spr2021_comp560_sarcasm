
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

posadv([X|T],T):-adveb(X,A,B),A>0, A>B.
negadv([X|T],T):-adveb(X,A,B),B>A,B>0.
neuadv([X|T],T):-adveb(X,A,B),B=A.

sarcastic_sentence--> sarcasm.
sarcastic_sentence--> sentence,sarcasm.
sarcastic_sentence--> sarcasm, sentence.
sarcastic_sentence--> sentence,sentence,sarcasm.
sarcastic_sentence--> sentence,sarcasm,sentence.
sarcastic_sentence--> sarcasm,sentence,sentence.
sarcastic_sentence--> sarcasm,sentence,sentence,sentence.
sarcastic_sentence--> sentence,sarcasm,sentence,sentence.
sarcastic_sentence--> sentence,sentence,sarcasm,sentence.
sarcastic_sentence--> sentence,sentence,sentence,sarcasm.

sentence-->neuphrases.
sentence-->conj,neuphrases,neuphrases.
sentence-->neuphrases,neuphrases.
sentence-->neuphrases,conj,neuphrases.
sentence-->posphrases.
sentence-->conj,posphrases,posphrases.
sentence-->posphrases,posphrases.
sentence-->posphrases,conj,posphrases.
sentence-->negphrases.
sentence-->conj,negphrases,negphrases.
sentence-->negphrases,negphrases.
sentence-->negphrases,conj,negphrases.

negsentence--> negphrases, neuphrases.
negsentence--> neuphrases, negphrases.
negsentence--> negphrases, negphrases.

negsentence--> negphrases,conj, neuphrases.
negsentence--> neuphrases,conj, negphrases.
negsentence--> negphrases,conj, negphrases.

negsentence--> conj, negphrases, neuphrases.
negsentence--> conj, neuphrases, negphrases.
negsentence--> conj, negphrases, negphrases.

possentence--> posphrases, neuphrases.
possentence--> neuphrases, posphrases.
possentence--> posphrases, posphrases.

possentence--> posphrases,conj, neuphrases.
possentence--> neuphrases,conj, posphrases.
possentence--> posphrases,conj, posphrases.

possentence--> conj, posphrases, neuphrases.
possentence--> conj, neuphrases, posphrases.
possentence--> conj, posphrases, posphrases.


sarcasm--> posphrases, negphrases.
sarcasm--> negphrases, posphrases.
sarcasm--> neuphrases, posphrases.

sarcasm-->possentence,negsentence.
sarcasm-->negsentence,possentence.

sarcasm--> negphrases, conj, posphrases.
sarcasm--> posphrases, conj, negphrases.
sarcasm--> negphrases, conj, posphrases.

sarcasm--> conj, negphrases, posphrases.
sarcasm--> conj, posphrases, negphrases.
sarcasm--> conj, neuphrases, posphrases.

posphrases-->posVP.
posphrases--> posNP, posVP.

neuphrases--> neuNP.
neuphrases--> neuVP.
neuphrases--> neuNP, neuVP.
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
posNP-->det, posn.
posNP-->posadj, posn.
posNP-->posadj, neun.
posNP-->det, posadj, posn.
posNP-->det, posadj, neun.

neuNP--> pronoun.
neuNP--> neun.
neuNP--> det, neun.
neuNP--> neuadj, neun.
neuNP--> det, neuadj, neun.

negNP--> negn.
negNP--> det, negn.
negNP--> det, negadj, neun.
negNP--> negadj, neun.
negNP--> det, negadj, negn.
negNP--> negadj, negn.

/***********************************verb phrases**************************************/

posVP--> pronoun, posv.
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

neuVP--> neuv.
neuVP--> pronoun, neuv.
neuVP--> neuadj, neuv.
neuVP--> neuv, neuadv.
neuVP--> neuadv, neuv.
neuVP--> pronoun, neuadv, neuv.
neuVP--> pronoun, neuv, neuadv.

negVP-->  negv.
negVP--> pronoun, negv.
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

