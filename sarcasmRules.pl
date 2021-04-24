
sarcasm-->phrases(negative), phrases(positive).
sarcasm-->phrases(positive), phrases(negative).
sarcasm-->phrases(neutral), phrases(positive).

phrases(positive)--> np(positive), vp(positive).
phrases(neutral)--> np(neutral), vp(neutral).
phrases(negative)--> np(negative), vp(negative).

phrases(positive)-->vp(positive).
phrases(negative)--> np(negative).

phrases(negative)--> adj(negative), np(_).
phrases(negative)--> adj(negative), np(_) ,vp(negative).
phrases(negative)-->vp(negative).


np(positive)-->n(_,positive).
np(positive)-->adj(_,positive), n(_,positive).
np(positive)-->adj(_,positive), n(_, nuetral).


np(neutral)--> n(_,neutral).
np(neutral)--> adj(_,neutral), n(_,neutral).


np(negative)--> n(_,negative).
np(negative)--> adj(_,negative), n(_,neutral).
np(negative)--> adj(_,negative), n(_,negative).


vp(positive)--> pronoun, v(_,postive).
vp(positive)--> adj(_,positive), v(_,neutral).
vp(positive)--> adj(_,positive), v(_,positive).
vp(positive)--> v(_,positive), adj(_,neutral).
vp(positive)--> v(_,positive), adj(_,positive).


vp(neutral)--> v(_,neutral).
vp(neutral)--> adj(_,neutral), v(_,neutral).


vp(negative)--> v(_,negative).
vp(negative)--> adj(_,negative), v(_,neutral).
vp(negative)--> adj(_,negative), v(_,negative).
vp(negative)--> v(_,neutral), adj(_,negative).
vp(negative)--> v(_,negative), adj(_,negative).
