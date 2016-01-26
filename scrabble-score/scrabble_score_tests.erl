-module(scrabble_score_tests).
-include_lib("eunit/include/eunit.hrl").

empty_word_scores_zero_test() ->
  ?assertEqual( 0, scrabble_score:score( "" ) ).

scores_very_short_word_test() ->
  ?assertEqual( 1, scrabble_score:score( "a" ) ).

scores_other_very_short_word_test() ->
  ?assertEqual( 4, scrabble_score:score( "f" ) ).

simple_word_scores_the_number_of_letters_test() ->
  ?assertEqual( 6, scrabble_score:score( "street" ) ).

complicated_word_scores_more_test() ->
  ?assertEqual( 22, scrabble_score:score( "quirky" ) ).

scores_are_case_insensitive() ->
  ?assertEqual( 41, scrabble_score:score( "oxyphenbutazone" ) ),
  ?assertEqual( 41, scrabble_score:score( "OXYPHENBUTAZONE" ) ).

  
