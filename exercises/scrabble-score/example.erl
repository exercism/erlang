-module(scrabble_score).

-export([score/1]).

score( Word ) ->
  lists:foldl(fun(X, Sum) -> get_char_value(X) + Sum end, 0, Word).

get_char_value( $q ) -> 10;
get_char_value( $z ) -> 10;
get_char_value( $j ) ->  8;
get_char_value( $x ) ->  8;
get_char_value( $k ) ->  5;
get_char_value( $f ) ->  4;
get_char_value( $h ) ->  4;
get_char_value( $v ) ->  4;
get_char_value( $w ) ->  4;
get_char_value( $y ) ->  4;
get_char_value( $b ) ->  3;
get_char_value( $c ) ->  3;
get_char_value( $m ) ->  3;
get_char_value( $p ) ->  3;
get_char_value( $d ) ->  2;
get_char_value( $g ) ->  2;
get_char_value( C ) when C >= $a, C =< $z ->  1;
get_char_value( C ) when C >= $A, C =< $Z ->
  [C2] = string:to_lower( [C] ),
  get_char_value( C2 ).  
