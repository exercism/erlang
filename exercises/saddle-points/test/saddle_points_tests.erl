%% based on canonical data version 1.3.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/saddle-points/canonical-data.json

-module(saddle_points_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

can_identify_single_saddle_point_test()	->
	Input=[
		[9, 8, 7],
		[5, 3, 2],
		[6, 6, 7]
	],
	Expected=[{1, 0}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_that_empty_matrix_has_no_saddle_points_test() ->
	Input=[
		[]
	],
	Expected=[],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_lack_of_saddle_points_when_there_are_none_test() ->
	Input=[
		[1, 2, 3],
		[3, 1, 2],
		[2, 3, 1]
	],
	Expected=[],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_multiple_saddle_points_in_a_column_test() ->
	Input=[
		[4, 5, 4],
		[3, 5, 5],
		[1, 5, 4]
	],
	Expected=[{0, 1}, {1, 1}, {2, 1}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_multiple_saddle_points_in_a_row_test() ->
	Input=[
		[6, 7, 8],
		[5, 5, 5],
		[7, 5, 6]
	],
	Expected=[{1, 0}, {1, 1}, {1, 2}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_saddle_point_in_bottom_right_corner_test() ->
	Input=[
		[8, 7, 9],
		[6, 7, 6],
		[3, 2, 5]
	],
	Expected=[{2, 2}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_saddle_points_in_a_non_square_matrix_test() ->
	Input=[
		[3, 1, 3],
		[3, 2, 4]
	],
	Expected=[{0, 0}, {0, 2}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_that_saddle_points_in_a_single_column_matrix_are_those_with_the_minimum_value_test() ->
	Input=[
		[2],
		[1],
		[4],
		[1]
	],
	Expected=[{1, 0}, {3, 0}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).

can_identify_that_saddle_points_in_a_single_row_matrix_are_those_with_the_maximum_value_test() ->
	Input=[
		[2, 5, 3, 5]
	],
	Expected=[{0, 1}, {0, 3}],
	?assertMatch(Expected, lists:sort(saddle_points:saddle_points(Input))).
