-module( largest_series_product_tests ).
-include_lib("eunit/include/eunit.hrl").

three_test() -> ?assert( 504 =:= largest_series_product:from_string("0123456789", 3) ).

five_test() -> ?assert( 15120 =:= largest_series_product:from_string("0123456789", 5) ).

six_test() -> ?assert( 23520 =:= largest_series_product:from_string("73167176531330624919225119674426574742355349194934", 6) ).

all_zeroes_test() -> ?assert( 0 =:= largest_series_product:from_string("0000", 2) ).

all_contain_zeroes_test() -> ?assert( 0 =:= largest_series_product:from_string("99099", 3) ).

too_long_test() -> ?assertError(_, largest_series_product:from_string("123", 4) ).

empty_product_test() -> ?assert( 1 =:= largest_series_product:from_string("", 0) ).

nonempty_string_empty_product_test() -> ?assert( 1 =:= largest_series_product:from_string("123", 0) ).

empty_string_nonzero_span_test() -> ?assertError(_, largest_series_product:from_string("", 1) ).
