%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/minesweeper/canonical-data.json

-module(minesweeper_tests).

-define(TESTED_MODULE, (sut(minesweeper))).
-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

no_rows_test() ->
	Input=[],
	Expected=[],
	?assertMatch(Expected, minesweeper:annotate(Input)).

no_columns_test() ->
	Input=[""],
	Expected=[""],
	?assertMatch(Expected, minesweeper:annotate(Input)).

no_mines_test() ->
	Input=[
		"   ",
		"   ",
		"   "
	],
	Expected=[
		"   ",
		"   ",
		"   "
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

only_mines_test() ->
	Input=[
		"***",
		"***",
		"***"
	],
	Expected=[
		"***",
		"***",
		"***"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

mine_surrounded_by_spaces_test() ->
	Input=[
		"   ",
		" * ",
		"   "
	],
	Expected=[
		"111",
		"1*1",
		"111"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

space_surrounded_by_mines_test() ->
	Input=[
		"***",
		"* *",
		"***"
	],
	Expected=[
		"***",
		"*8*",
		"***"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

horizontal_line_test() ->
	Input=[" * * "],
	Expected=["1*2*1"],
	?assertMatch(Expected, minesweeper:annotate(Input)).

horizontal_line_mines_at_edges_test() ->
	Input=["*   *"],
	Expected=["*1 1*"],
	?assertMatch(Expected, minesweeper:annotate(Input)).

vertical_line_test() ->
	Input=[
		" ",
		"*",
		" ",
		"*",
		" "
	],
	Expected=[
		"1",
		"*",
		"2",
		"*",
		"1"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

vertical_line_mines_at_edges_test() ->
	Input=[
		"*",
		" ",
		" ",
		" ",
		"*"
	],
	Expected=[
		"*",
		"1",
		" ",
		"1",
		"*"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

cross_test() ->
	Input=[
		"  *  ",
		"  *  ",
		"*****",
		"  *  ",
		"  *  "
	],
	Expected=[
		" 2*2 ",
		"25*52",
		"*****",
		"25*52",
		" 2*2 "
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

large_minefield_test() ->
	Input=[
		" *  * ",
		"  *   ",
		"    * ",
		"   * *",
		" *  * ",
		"      "
	],
	Expected=[
		"1*22*1",
		"12*322",
		" 123*2",
		"112*4*",
		"1*22*2",
		"111111"
	],
	?assertMatch(Expected, minesweeper:annotate(Input)).

version_test() ->
	?assertMatch(?TEST_VERSION, minesweeper:test_version()).
