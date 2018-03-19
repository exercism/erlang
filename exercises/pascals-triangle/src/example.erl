-module(example).

-export([gen_pascals_triangle/1, test_version/0]).

gen_pascals_triangle(N) when N < 0 -> -1;
gen_pascals_triangle(0) -> [];
gen_pascals_triangle(N) -> 
	gen_pascals_triangle_helper(1, N, []).

gen_pascals_triangle_helper(Count, N, CurrentResult) ->
	case Count > N of 
		true -> CurrentResult;
		false -> 
			gen_pascals_triangle_helper(
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

test_version() -> 1.
