%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/palindrome-products/canonical-data.json

-module(palindrome_products_tests).

-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

smallest_from_single_digit_factors_test() ->
	?assertMatch({1, [{1, 1}]}, normalize_output(palindrome_products:smallest(1, 9))).

largest_from_single_digit_factors_test() ->
	?assertMatch({9, [{1, 9}, {3, 3}]}, normalize_output(palindrome_products:largest(1, 9))).

smallest_from_double_digit_factors_test() ->
	?assertMatch({121, [{11, 11}]}, normalize_output(palindrome_products:smallest(10, 99))).

largest_from_double_digit_factors_test() ->
	?assertMatch({9009, [{91, 99}]}, normalize_output(palindrome_products:largest(10, 99))).

smallest_from_triple_digit_factors_test() ->
	?assertMatch({10201, [{101, 101}]}, normalize_output(palindrome_products:smallest(100, 999))).

largest_from_triple_digit_factors_test() ->
	?assertMatch({906609, [{913, 993}]}, normalize_output(palindrome_products:largest(100, 999))).

smallest_from_four_digit_factors_test() ->
	?assertMatch({1002001, [{1001, 1001}]}, normalize_output(palindrome_products:smallest(1000, 9999))).

largest_from_four_digit_factors_test() ->
	?assertMatch({99000099, [{9901, 9999}]}, normalize_output(palindrome_products:largest(1000, 9999))).

smallest_none_in_range_test() ->
	?assertMatch(undefined, palindrome_products:smallest(1002, 1003)).

largest_none_in_range_test() ->
	?assertMatch(undefined, palindrome_products:largest(15, 15)).

smallest_min_greater_than_max_test() ->
	?assertMatch({error, invalid_range}, palindrome_products:smallest(10000, 1)).

largest_min_greater_than_max_test() ->
	?assertMatch({error, invalid_range}, palindrome_products:largest(2, 1)).

normalize_output({Pal, Factors}) ->
	{
		Pal,
		lists:sort(
			lists:map(
				fun
					({A, B}) when A>B -> {B, A};
					(AB) -> AB
				end,
				Factors
			)
		)
	};

normalize_output(Other) -> Other.

version_test() ->
	?assertMatch(?TEST_VERSION, palindrome_products:test_version()).
