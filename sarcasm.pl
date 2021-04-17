:- consult([sentiword,determiners,sarcasmRules]).

n(X,positive):-noun(X,A,B),A>0, A>B.
n(X,negative):-noun(X,A,B),B>A,B>0.
n(X,neutral):-noun(X,A,B),B=A,A=0.

v(X,positive):-verb(X,A,B),A>0, A>B.
v(X,negative):-verb(X,A,B),B>A,B>0.
v(X,neutral):-verb(X,A,B),B=A,A=0.

adj(X,positive):-adjective(X,A,B),A>0, A>B.
adj(X,negative):-adjective(X,A,B),B>A,B>0.
adj(X,neutral):-adjective(X,A,B),B=A.

adv(X,positive):-adverb(X,A,B),A>0, A>B.
adv(X,negative):-adverb(X,A,B),B>A,B>0.
adve(X,neutral):-adverb(X,A,B),B=A.

start:- enter_sentence.
enter_sentence:-
write('Enter a sentence to compute: '), readln(L),write('Is sentence sarcastic? '),split_string(L, "\s", "\s", X),sarcasm(X).






