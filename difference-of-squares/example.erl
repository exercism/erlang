-module( difference_of_squares ).

-export( [sum_of_squares/1, square_of_sums/1] ).

sum_of_squares( N ) -> lists:sum( [square(X) || X <- lists:seq(1, N)] ).

square_of_sums( N ) -> square( lists:sum(lists:seq(1, N)) ).



square( N ) -> erlang:trunc( math:pow(N, 2) ).
