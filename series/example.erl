-module( series ).

-export( [from_string/2] ).

from_string( Width, String ) -> rows( erlang:length(String), Width, String ).



rows( Length, Width, [_H | T]=String ) when Length > Width ->
      {Row, _Rest} = lists:split( Width, String ),
      [Row | rows( Length - 1, Width, T )];
rows( _Length, _Width, String ) -> [String].
