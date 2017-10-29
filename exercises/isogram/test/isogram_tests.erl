-module(isogram_tests).

-define(TESTED_MODULE, (sut(isogram))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").

empty_string_test() ->
    ?assert(?TESTED_MODULE:is_isogram("")).

isogram_with_only_lower_case_characters_test() ->
    ?assert(?TESTED_MODULE:is_isogram("isogram")).

word_with_one_duplicated_character_test() ->
    ?assertNot(?TESTED_MODULE:is_isogram("eleven")).

longest_reported_english_isogram_test() ->
    ?assert(?TESTED_MODULE:is_isogram("subdermatoglyphic")).

word_with_duplicated_character_in_mixed_case_test() ->
    ?assertNot(?TESTED_MODULE:is_isogram("Alphabet")).

hypothetical_isogrammic_word_with_hyphen_test() ->
    ?assert(?TESTED_MODULE:is_isogram("thumbscrew-japingly")).

isogram_with_duplicated_hyphen_test() ->
    ?assert(?TESTED_MODULE:is_isogram("six-year-old")).

made_up_name_that_is_an_isogram_test() ->
    ?assert(?TESTED_MODULE:is_isogram("Emily Jung Schwartzkopf")).

duplicated_character_in_the_middle_test() ->
    ?assertNot(?TESTED_MODULE:is_isogram("accentor")).
