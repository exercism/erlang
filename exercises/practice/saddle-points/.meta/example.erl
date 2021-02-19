-module(example).

-export([saddle_points/1]).

saddle_points([]) ->
	[];
saddle_points(Matrix) ->
	find_saddle_points(coordinatize_matrix(Matrix)).

coordinatize_matrix(Matrix) ->
	Rows=length(Matrix),
	Cols=length(hd(Matrix)),
	Coords=[[{R, C} || C <- lists:seq(0, Cols-1)] || R <- lists:seq(0, Rows-1)],
	lists:zip(lists:flatten(Coords), lists:flatten(Matrix)).

find_saddle_points(CoordsMatrix) ->
	lists:foldl(
		fun
			({Coords={R, C}, V}, Acc) ->
				case
					lists:all(
						fun
							({{R2, _}, V2}) when R2=:=R -> V>=V2;
							({{_, C2}, V2}) when C2=:=C -> V=<V2;
							(_) -> true
						end,
						CoordsMatrix
					)
				of
					true -> [Coords|Acc];
					false -> Acc
				end
		end,
		[],
		CoordsMatrix
	).
