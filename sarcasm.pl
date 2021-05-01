:- consult([sarcasmRules]).



start:- enter_sentence.
enter_sentence:-
write('Enter a sentence to compute: '), read(Atom),atom_string(Atom,String),write('Is sentence sarcastic? '),
      split_string(String, "\s", "\s", X),  sarcastic_sentence(X,[]).







