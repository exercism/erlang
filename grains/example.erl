-module( grains ).
-export( [chess/0, per_square_and_sum/1] ).

chess() -> per_square_and_sum( 64 ).

per_square_and_sum( N ) -> lists:mapfoldl( fun pow_2_and_sum/2, 0, lists:seq(1, N) ).



pow_2_and_sum( N, Acc ) ->
	       Pow_2 = erlang:trunc( math:pow(2, N - 1) ),
	       {{N, Pow_2}, Pow_2 + Acc}.