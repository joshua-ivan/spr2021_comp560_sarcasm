:- module(config, [ config/2 ]).

config(sarcastic_data_file_name, "data/sarcasticTweets.pl") :- !.
config(normal_data_file_name, "data/normalTweets.pl") :- !.
config(clean_sarcastic_data_file_name, "data/cleanSarcasticTweets.pl") :- !.
config(clean_normal_data_file_name, "data/cleanNormalTweets.pl") :- !.
config(sarcasm_score_lower_bound, 0.175) :- !.
config(sarcasm_score_upper_bound, 0.225) :- !.
config(results_file_name, "results.csv") :- !.
config(random_sample_size, 250) :- !.
config(silent, false) :- !.
