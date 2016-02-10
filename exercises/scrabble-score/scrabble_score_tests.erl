-module(scrabble_score_tests).
-include_lib("eunit/include/eunit.hrl").

-define(checkScore(N, S), ?assertEqual(N, scrabble_score:score(S))).

empty_word_scores_zero_test() -> ?checkScore(0, "").

scores_very_short_word_test() -> ?checkScore(1, "a").

scores_other_very_short_word_test() -> ?checkScore(4, "f").

simple_word_scores_the_number_of_letters_test() -> ?checkScore(6, "street").

complicated_word_scores_more_test() -> ?checkScore(22, "quirky").

scores_are_case_insensitive_test() ->
  ?checkScore(41, "oxyphenbutazone"),
  ?checkScore(41, "OXYPHENBUTAZONE").
