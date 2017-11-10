-module(luhn_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

single_digit_strings_can_not_be_valid_test() ->
  ?assertNot(luhn:valid("1")).

a_single_zero_is_invalid_test() ->
  ?assertNot(luhn:valid("0")).

a_simple_valid_sin_that_remains_valid_if_reversed_test() ->
  ?assert(luhn:valid("059")).

a_simple_valid_sin_that_becomes_invalid_if_reversed_test() ->
  ?assert(luhn:valid("59")).

a_valid_canadian_sin_test() ->
  ?assert(luhn:valid("055 444 285")).

invalid_canadian_sin_test() ->
  ?assertNot(luhn:valid("055 444 286")).

invalid_credit_card_test() ->
  ?assertNot(luhn:valid("8273 1232 7352 0569")).

valid_strings_with_a_non_digit_included_become_invalid_test() ->
  ?assertNot(luhn:valid("055a 444 285")).

valid_strings_with_punctuation_included_become_invalid_test() ->
  ?assertNot(luhn:valid("055-444-285")).

valid_strings_with_symbols_included_become_invalid_test() ->
  ?assertNot(luhn:valid("055£ 444$ 285")).

single_zero_with_space_is_invalid_test() ->
  ?assertNot(luhn:valid(" 0")).

more_than_a_single_zero_is_valid_test() ->
  ?assert(luhn:valid("0000 0")).

input_digit_9_is_correctly_converted_to_output_digit_9_test() ->
  ?assert(luhn:valid("091")).

version_test() ->
  ?assertMatch(2, luhn:test_version()).
