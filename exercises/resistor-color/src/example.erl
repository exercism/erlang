-module(example).

-export([color_code/1, colors/0]).

-define(COLORVALUES, #{
	black => 0,
	brown => 1,
	red => 2,
	orange => 3,
	yellow => 4,
	green => 5,
	blue => 6,
	violet => 7,
	grey => 8,
	white => 9
}).


color_code(Color) ->
	maps:get(Color, ?COLORVALUES).

colors() ->
	[Color || {Color, _} <- lists:keysort(2, maps:to_list(?COLORVALUES))].
