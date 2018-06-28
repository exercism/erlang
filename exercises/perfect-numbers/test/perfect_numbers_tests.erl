%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/perfect-numbers/canonical-data.json

-module(perfect_numbers_tests).

-define(TESTED_MODULE, (sut(perfect_numbers))).
-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

perfect_smallest_test() ->
	?assertMatch(perfect, perfect_numbers:classify(6)).

perfect_medium_test() ->
	?assertMatch(perfect, perfect_numbers:classify(28)).

perfect_large_test() ->
	?assertMatch(perfect, perfect_numbers:classify(33550336)).

abundant_smallest_test() ->
	?assertMatch(abundant, perfect_numbers:classify(12)).

abundant_medium_test() ->
	?assertMatch(abundant, perfect_numbers:classify(30)).

abundant_large_test() ->
	?assertMatch(abundant, perfect_numbers:classify(33550335)).

deficient_smallest_prime_test() ->
	?assertMatch(deficient, perfect_numbers:classify(2)).

deficient_smallest_non_prime_test() ->
	?assertMatch(deficient, perfect_numbers:classify(4)).

deficient_medium_test() ->
	?assertMatch(deficient, perfect_numbers:classify(32)).

deficient_large_test() ->
	?assertMatch(deficient, perfect_numbers:classify(33550337)).

deficient_edge_case_1_test() ->
	?assertMatch(deficient, perfect_numbers:classify(1)).

invalid_zero_test() ->
	?assertMatch({error, "Classification is only possible for natural numbers."}, perfect_numbers:classify(0)).

invalid_negative_test() ->
	?assertMatch({error, "Classification is only possible for natural numbers."}, perfect_numbers:classify(-1)).
