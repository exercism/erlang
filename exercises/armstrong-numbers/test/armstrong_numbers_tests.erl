%% based on canonical data version 1.0.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/armstrong-numbers/canonical-data.json

-module(armstrong_numbers_tests).

-define(TESTED_MODULE, (sut(armstrong_numbers))).
-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

single_digit_numbers_test() ->
	?assert(armstrong_numbers:is_armstrong_number(5)).

two_digit_numbers_test() ->
	?assertNot(armstrong_numbers:is_armstrong_number(10)).

three_digit_armstrong_numbers_test() ->
	?assert(armstrong_numbers:is_armstrong_number(153)).

three_digit_not_armstrong_numbers_test() ->
	?assertNot(armstrong_numbers:is_armstrong_number(100)).

four_digit_armstrong_numbers_test() ->
	?assert(armstrong_numbers:is_armstrong_number(9474)).

four_digit_not_armstrong_numbers_test() ->
	?assertNot(armstrong_numbers:is_armstrong_number(9475)).

seven_digit_armstrong_numbers_test() ->
	?assert(armstrong_numbers:is_armstrong_number(9926315)).

seven_digit_not_armstrong_numbers_test() ->
	?assertNot(armstrong_numbers:is_armstrong_number(9926314)).
