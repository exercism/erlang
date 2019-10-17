-module(saddle_points).

-export([saddle_points/1]).

-type saddle_point() :: {integer(), integer()}.

-spec saddle_points([[integer()]]) -> [saddle_point()].

saddle_points(_Matrix) ->
	undefined.
