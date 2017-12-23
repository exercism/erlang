-module(pangram_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


% test cases adapted from `x-common//canonical-data.json` @ version: 1.3.0

empty_sentence_test() ->
    ?assertNot(pangram:is_pangram("")).

perfect_lower_case_pangram_test() ->
    ?assert(pangram:is_pangram("abcdefghijklmnopqrstuvwxyz")).

pangram_with_only_lower_case_test() ->
    ?assert(pangram:is_pangram("the quick brown fox jumps over the lazy dog")).

missing_character_x_test() ->
    ?assertNot(pangram:is_pangram("a quick movement of the enemy will jeopardize five gunboats")).

missing_character_h_test() ->
    ?assertNot(pangram:is_pangram("five boxing wizards jump quickly at it")).

pangram_with_underscores_test() ->
    ?assert(pangram:is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog")).

pangram_with_numbers_test() ->
    ?assert(pangram:is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs")).

missing_letters_replaced_by_numbers_test() ->
    ?assertNot(pangram:is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")).

pangram_with_mixed_case_and_punctuation_test() ->
    ?assert(pangram:is_pangram("\"Five quacking Zephyrs jolt my wax bed.\"")).

upper_and_lower_case_characters_are_not_counted_separately_test() ->
    ?assertNot(pangram:is_pangram("the quick brown fox jumps over with lazy FX")).
