-module(example).

-export([winner/1]).

winner(Board) ->
	find_winner(group(parse_board(Board))).


parse_board(Board) ->
	maps:from_list(
		lists:filter(
			fun
				({_, empty}) -> false;
				(_) -> true
			end,
			parse_board(Board, 0, [])
		)
	).

parse_board([Row], RowIdx, []) ->
	parse_row(Row, top_bottom, RowIdx);
parse_board([Row|More], RowIdx, []) ->
	parse_board(More, RowIdx+1, [parse_row(Row, top, RowIdx)]);
parse_board([Row], RowIdx, Acc) ->
	lists:flatten([parse_row(Row, bottom, RowIdx)|Acc]);
parse_board([Row|More], RowIdx, Acc) ->
	parse_board(More, RowIdx+1, [parse_row(Row, inner, RowIdx)|Acc]).


parse_row(Row, RowTag, RowIdx) ->
	parse_row(Row, RowTag, RowIdx, 0, []).

parse_row([], _, _, _, Acc) ->
	Acc;
parse_row([16#20|More], RowTag, RowIdx, ColIdx, Acc) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, Acc);
parse_row([$.|More], RowTag, RowIdx, ColIdx, Acc) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, [{{ColIdx, RowIdx}, empty}|Acc]);
parse_row([$X], RowTag, RowIdx, ColIdx, []) ->
	[{{ColIdx, RowIdx}, {x, {ColIdx, RowIdx}, {left_right, RowTag}}}];
parse_row([$X|More], RowTag, RowIdx, ColIdx, []) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, [{{ColIdx, RowIdx}, {x, {ColIdx, RowIdx}, {left, RowTag}}}]);
parse_row([$X], RowTag, RowIdx, ColIdx, Acc) ->
	[{{ColIdx, RowIdx}, {x, {ColIdx, RowIdx}, {right, RowTag}}}|Acc];
parse_row([$X|More], RowTag, RowIdx, ColIdx, Acc) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, [{{ColIdx, RowIdx}, {x, {ColIdx, RowIdx}, {inner, RowTag}}}|Acc]);
parse_row([$O], RowTag, RowIdx, ColIdx, []) ->
	[{{ColIdx, RowIdx}, {o, {ColIdx, RowIdx}, {left_right, RowTag}}}];
parse_row([$O|More], RowTag, RowIdx, ColIdx, []) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, [{{ColIdx, RowIdx}, {o, {ColIdx, RowIdx}, {left, RowTag}}}]);
parse_row([$O], RowTag, RowIdx, ColIdx, Acc) ->
	[{{ColIdx, RowIdx}, {o, {ColIdx, RowIdx}, {right, RowTag}}}|Acc];
parse_row([$O|More], RowTag, RowIdx, ColIdx, Acc) ->
	parse_row(More, RowTag, RowIdx, ColIdx+1, [{{ColIdx, RowIdx}, {o, {ColIdx, RowIdx}, {inner, RowTag}}}|Acc]).


get_adjacent({X, Y}, Player, Board) ->
	maps:filter(
		fun
			(_, {P, _, _}) when P=/=Player -> false;
			({X2, Y2}, _) when X2=:=X-2 andalso Y2=:=Y -> true;
			({X2, Y2}, _) when X2=:=X+2 andalso Y2=:=Y -> true;
			({X2, Y2}, _) when X2=:=X+1 andalso Y2=:=Y-1 -> true;
			({X2, Y2}, _) when X2=:=X-1 andalso Y2=:=Y-1 -> true;
			({X2, Y2}, _) when X2=:=X+1 andalso Y2=:=Y+1 -> true;
			({X2, Y2}, _) when X2=:=X-1 andalso Y2=:=Y+1 -> true;
			(_, _) -> false
		end,
		Board
	).


group(Board) ->
	group(maps:to_list(Board), Board).

group([], Board) ->
	maps:fold(
		fun
			(_, {_, _, {inner, inner}}, Acc) ->
				Acc;

			(_, {P, G, CRTag}, Acc) ->
				Acc#{{P, G} => [CRTag|maps:get({P, G}, Acc, [])]}
		end,
		#{},
		Board
	);
group([{Coords, {Player, Group, _}}|More], Board) ->
	Adj=get_adjacent(Coords, Player, Board),
	Board2=
	maps:fold(
		fun
			(_, {_, Group2, _}, Acc) when Group2=:=Group ->
				Acc;

			(_, {_, Group2, _}, Acc) ->
				maps:map(
					fun
						(_, {Player3, Group3, CRTag3}) when Group3=:=Group2 -> {Player3, Group, CRTag3};
						(_, V3) -> V3
					end,
					Acc
				)
		end,
		Board,
		Adj
	),
	group(More, Board2).


find_winner(Groups) ->
	maps:fold(
		fun
			({o, _}, CRTag, undefined) ->
				case
					lists:foldl(
						fun
							(_, Acc={true, true}) -> Acc;
							({_, top}, {_, Acc2}) -> {true, Acc2};
							({_, bottom}, {Acc1, _}) -> {Acc1, true};
							({_, top_bottom}, _) -> {true, true};
							(_, Acc) -> Acc
						end,
						{false, false},
						CRTag
					)
				of
					{true, true} -> o;
					_ -> undefined
				end;

			({x, _}, CRTag, undefined) ->
				case
					lists:foldl(
						fun
							(_, Acc={true, true}) -> Acc;
							({left, _}, {_, Acc2}) -> {true, Acc2};
							({right, _}, {Acc1, _}) -> {Acc1, true};
							({left_right, _}, _) -> {true, true};
							(_, Acc) -> Acc
						end,
						{false, false},
						CRTag
					)
				of
					{true, true} -> x;
					_ -> undefined
				end;
			(_, _, Acc) -> Acc
		end,
		undefined,
		Groups
	).
