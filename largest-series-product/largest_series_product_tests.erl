-module( largest_series_product_tests ).
-include_lib("eunit/include/eunit.hrl").

three_test() -> ?assert( 504 =:= largest_series_product:from_string("0123456789", 3) ).

five_test() -> ?assert( 15120 =:= largest_series_product:from_string("0123456789", 5) ).

six_test() -> ?assert( 23520 =:= largest_series_product:from_string("73167176531330624919225119674426574742355349194934", 6) ).
