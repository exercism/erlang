%% based on canonical data version 1.2.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/change/canonical-data.json

-module(change_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

single_coin_change_test() ->
	Target=25,
	Coins=[1, 5, 10, 25, 100],
	Expected=[25],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

multiple_coin_change_test() ->
	Target=15,
	Coins=[1, 5, 10, 25, 100],
	Expected=[5, 10],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

change_with_lilliputian_coins_test() ->
	Target=23,
	Coins=[1, 4, 15, 20, 50],
	Expected=[4, 4, 15],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

change_with_lower_elbonia_coins_test() ->
	Target=63,
	Coins=[1, 5, 10, 21, 25],
	Expected=[21, 21, 21],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

large_target_values_test() ->
	Target=999,
	Coins=[1, 2, 5, 10, 20, 50, 100],
	Expected=[2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

no_unit_coins_available_test() ->
	Target=21,
	Coins=[2, 5, 10, 20, 50],
	Expected=[2, 2, 2, 5, 10],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

another_no_unit_coins_available_test() ->
	Target=27,
	Coins=[4, 5],
	Expected=[4, 4, 4, 5, 5, 5],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

zero_target_test() ->
	Target=0,
	Coins=[1, 5, 10, 21, 25],
	Expected=[],
	Actual=change:find_fewest_coins(Target, Coins),
	?assertMatch(Expected, lists:sort(Actual)).

target_smaller_than_smallest_coin_test() ->
	Target=3,
	Coins=[5, 10],
	Expected=undefined,
	?assertMatch(Expected, change:find_fewest_coins(Target, Coins)).

coins_do_not_add_up_to_target_test() ->
	Target=94,
	Coins=[5, 10],
	Expected=undefined,
	?assertMatch(Expected, change:find_fewest_coins(Target, Coins)).

negative_target_test() ->
	Target=-5,
	Coins=[1, 2, 5],
	Expected={error, invalid_target_value},
	?assertMatch(Expected, change:find_fewest_coins(Target, Coins)).
