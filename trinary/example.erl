-module( trinary ).

-export( [to_decimal/1] ).

to_decimal( String ) ->
	    try
	    erlang:list_to_integer( String, 3 )

	    catch
	    _:_ -> 0

	    end.

