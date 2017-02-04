-module(difference_of_squares_tests).

-define(TESTED_MODULE, (sut(difference_of_squares))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


-define(assertSumOfSquares(Expected, Number), ?assertEqual(Expected, ?TESTED_MODULE:sum_of_squares(Number))).
-define(assertSquareOfSums(Expected, Number), ?assertEqual(Expected, ?TESTED_MODULE:square_of_sums(Number))).
-define(assertDifference(Expected, Number), ?assertEqual(Expected, ?TESTED_MODULE:difference_of_squares(Number))).

%% Square the sum of the numbers up to the given number

square_of_sums_5_test() ->
  ?assertSquareOfSums( 225, 5 ).

square_of_sums_10_test() ->
  ?assertSquareOfSums( 3025, 10 ).

square_of_sums_100_test() ->
  ?assertSquareOfSums( 25502500, 100 ).

%% Sum the squares of the numbers up to the given number

sum_of_square_5_test() ->
  ?assertSumOfSquares( 55, 5 ).

sum_of_square_10_test() ->
  ?assertSumOfSquares( 385, 10 ).

sum_of_square_100_test() ->
  ?assertSumOfSquares( 338350, 100 ).

%% Subtract sum of squares from square of sums

difference_of_squares_0_test() ->
  ?assertDifference( 0, 0 ).

difference_of_squares_5_test() ->
  ?assertDifference( 170, 5 ).

difference_of_squares_10_test() ->
  ?assertDifference( 2640, 10 ).

difference_of_squares_100_test() ->
  ?assertDifference( 25164150, 100 ).
