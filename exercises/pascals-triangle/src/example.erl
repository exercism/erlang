-module(example).

-export([rows/1]).

rows(N) when N < 0 -> -1;
rows(0) -> [];
rows(N) -> 
	rows_helper(1, N, []).

rows_helper(Count, N, CurrentResult) ->
	case Count > N of 
		true -> CurrentResult;
		false -> 
			rows_helper(
				Count + 1, 
				N, 
				CurrentResult ++ gen_next(CurrentResult))
	end.

gen_next([]) -> [[1]];
gen_next(CurrentResult) ->
	LastRowDropLast = lists:droplast(lists:last(CurrentResult)),
	ReverseLastRowDropLast = lists:reverse(LastRowDropLast),
	ZipList = lists:zipwith(
		fun(X, Y) -> X + Y end,
		LastRowDropLast, 
		ReverseLastRowDropLast),
	[[1] ++ ZipList ++ [1]].
