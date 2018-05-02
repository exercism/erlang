-module(pascals_triangle_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


% test cases adapted from `x-common//canonical-data.json` @ version: 1.3.0

zero_row_test() ->
  ?assertEqual([], pascals_triangle:gen_pascals_triangle(0)).

one_row_test() ->
  ?assertEqual([[1]], pascals_triangle:gen_pascals_triangle(1)).

two_rows_test() ->
  ?assertEqual([[1], [1, 1]], pascals_triangle:gen_pascals_triangle(2)).

three_rows_test() ->
  ?assertEqual([[1], [1, 1], [1, 2, 1]], pascals_triangle:gen_pascals_triangle(3)).

four_rows_test() ->
  ?assertEqual(
    [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]], 
    pascals_triangle:gen_pascals_triangle(4)).

five_rows_test() ->
  ?assertEqual(
    [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]], 
    pascals_triangle:gen_pascals_triangle(5)).

six_rows_test() ->
  ?assertEqual(
    [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1]], 
    pascals_triangle:gen_pascals_triangle(6)).

ten_rows_test() ->
  ?assertEqual(
    [[1], 
    [1, 1], 
    [1, 2, 1], 
    [1, 3, 3, 1], 
    [1, 4, 6, 4, 1], 
    [1, 5, 10, 10, 5, 1], 
    [1, 6, 15, 20, 15, 6, 1], 
    [1, 7, 21, 35, 35, 21, 7, 1], 
    [1, 8, 28, 56, 70, 56, 28, 8, 1], 
    [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]],
    pascals_triangle:gen_pascals_triangle(10)).

negative_rows_test() ->
  ?assertEqual(-1, pascals_triangle:gen_pascals_triangle(-1)).