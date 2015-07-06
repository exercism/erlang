-module(difference_of_squares_tests).
-include_lib("eunit/include/eunit.hrl").

ten_test() ->
  Sum_of_squares = difference_of_squares:sum_of_squares( 10 ),
  Square_of_sums = difference_of_squares:square_of_sums( 10 ),
  ?assert( Square_of_sums - Sum_of_squares =:= 2640 ).
