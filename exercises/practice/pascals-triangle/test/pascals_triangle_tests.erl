%% Generated with 'testgen v0.2.0'
%% Revision 1 of the exercises generator was used
%% https://github.com/exercism/problem-specifications/raw/42dd0cea20498fd544b152c4e2c0a419bb7e266a/exercises/pascals-triangle/canonical-data.json
%% This file is automatically generated from the exercises canonical data.

-module(pascals_triangle_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_zero_rows_test_'() ->
    {"zero rows",
     ?_assertMatch([], pascals_triangle:rows(0))}.

'2_single_row_test_'() ->
    {"single row",
     ?_assertMatch([[1]], pascals_triangle:rows(1))}.

'3_two_rows_test_'() ->
    {"two rows",
     ?_assertMatch([[1], [1, 1]], pascals_triangle:rows(2))}.

'4_three_rows_test_'() ->
    {"three rows",
     ?_assertMatch([[1], [1, 1], [1, 2, 1]],
		   pascals_triangle:rows(3))}.

'5_four_rows_test_'() ->
    {"four rows",
     ?_assertMatch([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]],
		   pascals_triangle:rows(4))}.

'6_five_rows_test_'() ->
    {"five rows",
     ?_assertMatch([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1],
		    [1, 4, 6, 4, 1]],
		   pascals_triangle:rows(5))}.

'7_six_rows_test_'() ->
    {"six rows",
     ?_assertMatch([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1],
		    [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1]],
		   pascals_triangle:rows(6))}.

'8_ten_rows_test_'() ->
    {"ten rows",
     ?_assertMatch([[1], [1, 1], [1, 2, 1], [1, 3, 3, 1],
		    [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1],
		    [1, 6, 15, 20, 15, 6, 1], [1, 7, 21, 35, 35, 21, 7, 1],
		    [1, 8, 28, 56, 70, 56, 28, 8, 1],
		    [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]],
		   pascals_triangle:rows(10))}.
