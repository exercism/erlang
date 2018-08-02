-module(example).

-export([find_fewest_coins/2, test_version/0]).

find_fewest_coins(0, _) ->
	[];

find_fewest_coins(Target, _) when Target<0 ->
	{error, invalid_target_value};

find_fewest_coins(Target, Coins) ->
	find_best(Target, Coins).


find_best(Target, Coins) ->
	find_best(Target, lists:reverse(lists:sort(Coins)), undefined).

find_best(_, [], Best) -> Best;

find_best(Target, Coins=[_|MoreCoins], Best) ->
	find_best2(Target, MoreCoins, get_change(Target, Coins), Best).

find_best2(Target, MoreCoins, undefined, Best) ->
	find_best(Target, MoreCoins, Best);

find_best2(Target, MoreCoins, Current, undefined) ->
	find_best(Target, MoreCoins, Current);

find_best2(Target, MoreCoins, Current, Best) when length(Current)>length(Best) ->
	find_best(Target, MoreCoins, Best);

find_best2(Target, MoreCoins, Current, _) ->
	find_best(Target, MoreCoins, Current).


get_change(Target, Coins) ->
	get_change(Target, Coins, []).

get_change(0, _, Acc) -> Acc;

get_change(_, [], _) -> undefined;

get_change(Target, _, _) when Target<0 -> undefined;

get_change(Target, [Coin|More], Acc) when Coin>Target ->
	get_change(Target, More, Acc);

get_change(Target, Coins=[Coin|MoreCoins], Acc) ->
	get_change2(Target, MoreCoins, get_change(Target-Coin, Coins, [Coin|Acc]), Acc).

get_change2(Target, MoreCoins, undefined, Acc) ->
	get_change(Target, MoreCoins, Acc);

get_change2(_, _, Current, _) ->
	Current.

	 

test_version() -> 1.
