-module(sum_of_multiples_tests).
-import(sum_of_multiples, [sumOfMultiplesDefault/1, sumOfMultiples/2]).

-include_lib("eunit/include/eunit.hrl").

sum_to_1_test() ->
  ?assertEqual(0, sumOfMultiplesDefault(1)).

sum_to_3_test() ->
  ?assertEqual(3, sumOfMultiplesDefault(4)).

sum_to_10_test() ->
  ?assertEqual(23, sumOfMultiplesDefault(10)).
  
sum_to_100_test() ->
  ?assertEqual(2318, sumOfMultiplesDefault(100)).

sum_to_1000_test() ->
  ?assertEqual(233168, sumOfMultiplesDefault(1000)).

sum_of_configurable_to_20_test() ->
  ?assertEqual(51, sumOfMultiples([7,13,17], 20)).

sum_of_configurable_to_10000_test() ->
  ?assertEqual(2203160, sumOfMultiples([43,47], 10000)).
