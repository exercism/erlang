-module(example).

-export([encode/2, decode/2, test_version/0]).


encode(Message, Rails) ->
	[C || {_, C} <- enrail(Message, Rails)].

decode(Message, Rails) ->
	Tmp=lists:zipwith(
		fun
			({Pos, undefined}, C) -> {Pos, C}
		end,
		enrail([undefined || _ <- Message], Rails),
		Message),
	[C || {_, C} <- lists:sort(Tmp)].


enrail(Data, Rails) ->
	enrail(down, 0, Data, [], [[] || _ <- lists:seq(1, Rails)]).

enrail(down, _, [], Left, Right) ->
	lists:reverse(lists:flatten(lists:reverse(Right)++Left));

enrail(up, _, [], Left, Right) ->
	lists:flatten([lists:reverse(L) || L <- lists:reverse(Right)++Left]);

enrail(down, Idx, Message, [H|T], []) ->
	enrail(up, Idx, Message, [H], T);

enrail(up, Idx, Message, [H|T], []) ->
	enrail(down, Idx, Message, [H], T);

enrail(Direction, Idx, [C|Message], Left, [R|Right]) ->
	enrail(Direction, Idx+1, Message, [[{Idx, C}|R]|Left], Right).


test_version() -> 1.
