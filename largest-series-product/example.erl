-module( largest_series_product ).

-export( [from_string/2 ] ).

from_string( String, N ) -> from_string( erlang:length(String), String, N ).



from_string( Length, String, N ) when Length >= N ->
  Sets = sets( Length, N, String ),
  lists:max( [product(X) || X <- Sets] ).

product( Set ) -> lists:foldl( fun product/2, 1, Set ).
product( C, Acc ) when C >= $0, C =< $9 -> (C - $0) * Acc.

sets( Length, Width, [_ | T]=String ) when Length > Width ->
  Set = lists:sublist( String, Width ),
  [Set | sets( Length - 1, Width, T )];
sets( _Length, _Width, String ) -> [String].
