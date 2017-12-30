-module(example). % binary is a "sticky module" so we have to use another name.
-export( [to_decimal/1, test_version/0] ).

to_decimal( String ) ->
  try
    {_N, Result} = lists:foldr( fun to_decimal/2, {0, 0}, String ),
    Result

  catch
    _:_ -> 0

  end.

test_version() ->
    1.



to_decimal( $0, {N, Acc} ) -> {N + 1, Acc};
to_decimal( $1, {N, Acc} ) -> {N + 1, Acc + erlang:trunc(math:pow(2, N))}.
