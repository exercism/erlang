-module( series_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

three_test() -> ?assert( series:from_string(3, "01234") =:= ["012", "123", "234"] ).

four_test() -> ?assert( series:from_string(4, "01234") =:= ["0123", "1234"] ).
