-module( series_tests ).

-define(TESTED_MODULE, (sut(series))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


three_test() -> ?assert( ?TESTED_MODULE:from_string(3, "01234") =:= ["012", "123", "234"] ).

four_test() -> ?assert( ?TESTED_MODULE:from_string(4, "01234") =:= ["0123", "1234"] ).
