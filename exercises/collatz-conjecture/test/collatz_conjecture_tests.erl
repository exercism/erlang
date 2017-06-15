-module('collatz_conjecture_tests').

-define(TESTED_MODULE, (sut(collatz_conjecture))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


zero_steps_for_one_test() ->
  ?assertEqual(0, ?TESTED_MODULE:steps(1)).

divide_if_even_test() ->
  ?assertEqual(4, ?TESTED_MODULE:steps(16)).

even_and_odd_steps_test() ->
  ?assertEqual(9, ?TESTED_MODULE:steps(12)).

large_number_of_even_and_odd_steps_test() ->
  ?assertEqual(152, ?TESTED_MODULE:steps(1000000)).
  
zero_is_an_error_test() ->
  ?assertEqual({error, "Only strictly positive numbers are allowed"}, ?TESTED_MODULE:steps(0)).

negative_value_is_an_error_test() ->
  ?assertEqual({error, "Only strictly positive numbers are allowed"}, ?TESTED_MODULE:steps(-15)).
