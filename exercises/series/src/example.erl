-module( example ).

-export( [from_string/2, test_version/0] ).

from_string( Width, String ) -> rows( erlang:length(String), Width, String ).

test_version() ->
    1.


rows( Length, Width, [_H | T]=String ) when Length > Width ->
  {Row, _Rest} = lists:split( Width, String ),
  [Row | rows( Length - 1, Width, T )];
rows( _Length, _Width, String ) -> [String].
