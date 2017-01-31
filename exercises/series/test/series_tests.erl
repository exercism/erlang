-module( series_tests ).

-include("exercism.hrl").
-include_lib( "eunit/include/eunit.hrl" ).

-define(TESTED_MODULE, (sut(series))).

three_test() -> ?assert( ?TESTED_MODULE:from_string(3, "01234") =:= ["012", "123", "234"] ).

four_test() -> ?assert( ?TESTED_MODULE:from_string(4, "01234") =:= ["0123", "1234"] ).
