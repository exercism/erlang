-module(example).

-export( [sum_of_squares/1, square_of_sums/1, difference_of_squares/1, test_version/0] ).

sum_of_squares( N ) -> lists:sum( [square(X) || X <- lists:seq(1, N)] ).

square_of_sums( N ) -> square( lists:sum(lists:seq(1, N)) ).

difference_of_squares( N ) -> square_of_sums( N ) - sum_of_squares( N ).

test_version() ->
    1.


square( N ) -> erlang:trunc( math:pow(N, 2) ).
