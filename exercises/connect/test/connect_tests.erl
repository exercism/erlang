%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/connect/canonical-data.json

-module(connect_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

an_empty_board_has_no_winner_test() ->
	Input=[
		". . . . .",
		" . . . . .",
		"  . . . . .",
		"   . . . . .",
		"    . . . . ."
	],
	Expected=undefined,
	?assertMatch(Expected, connect:winner(Input)).

x_can_win_on_a_1x1_board_test() ->
	Input=[
		"X"
	],
	Expected=x,
	?assertMatch(Expected, connect:winner(Input)).

o_can_win_on_a_1x1_board_test() ->
	Input=[
		"O"
	],
	Expected=o,
	?assertMatch(Expected, connect:winner(Input)).

only_edges_does_not_make_a_winner_test() ->
	Input=[
		"O O O X",
		" X . . X",
		"  X . . X",
		"   X O O O"
	],
	Expected=undefined,
	?assertMatch(Expected, connect:winner(Input)).

illegal_diagonal_does_not_make_a_winner_test() ->
	Input=[
		"X O . .",
		" O X X X",
		"  O X O .",
		"   . O X .",
		"    X X O O"
	],
	Expected=undefined,
	?assertMatch(Expected, connect:winner(Input)).

nobody_wins_crossing_adjacent_angles_test() ->
	Input=[
		"X . . .",
		" . X O .",
		"  O . X O",
		"   . O . X",
		"    . . O ."
	],
	Expected=undefined,
	?assertMatch(Expected, connect:winner(Input)).

x_wins_crossing_from_left_to_right_test() ->
	Input=[
		". O . .",
		" O X X X",
		"  O X O .",
		"   X X O X",
		"    . O X ."
	],
	Expected=x,
	?assertMatch(Expected, connect:winner(Input)).

o_wins_crossing_from_top_to_bottom_test() ->
	Input=[
		". O . .",
		" O X X X",
		"  O O O .",
		"   X X O X",
		"    . O X ."
	],
	Expected=o,
	?assertMatch(Expected, connect:winner(Input)).

x_wins_using_a_convoluted_path_test() ->
	Input=[
		". X X . .",
		" X . X . X",
		"  . X . X .",
		"   . X X . .",
		"    O O O O O"
	],
	Expected=x,
	?assertMatch(Expected, connect:winner(Input)).

x_wins_using_a_spiral_path_test() ->
	Input=[
		"O X X X X X X X X",
		" O X O O O O O O O",
		"  O X O X X X X X O",
		"   O X O X O O O X O",
		"    O X O X X X O X O",
		"     O X O O O X O X O",
		"      O X X X X X O X O",
		"       O O O O O O O X O",
		"        X X X X X X X X O"
	],
	Expected=x,
	?assertMatch(Expected, connect:winner(Input)).
