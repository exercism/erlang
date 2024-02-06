-module(reverse_string_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_reverse_an_empty_string_test_'() ->
    Input = "",
    Expected = "",
    {"reverse an empty string",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'2_reverse_a_word_test_'() ->
    Input = "robot",
    Expected = "tobor",
    {"reverse a word",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'3_reverse_a_capitalized_word_test_'() ->
    Input = "Ramen",
    Expected = "nemaR",
    {"reverse a capitalized word",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'4_reverse_a_sentence_with_punctuation_test_'() ->
    Input = "I'm hungry!",
    Expected = "!yrgnuh m'I",
    {"reverse a sentence with punctuation",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'5_reverse_a_palindrome_test_'() ->
    Input = "racecar",
    Expected = "racecar",
    {"reverse a palindrome",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'6_reverse_an_even_sized_word_test_'() ->
    Input = "drawer",
    Expected = "reward",
    {"reverse an even-sized word",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.

'7_reverse_wide_characters_test_'() ->
    Input = "子猫",
    Expected = "猫子",
    {"reverse wide characters",
     ?_assertEqual(Expected,
                   reverse_string:reverse(Input))}.
