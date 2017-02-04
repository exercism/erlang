-module(leap_tests).

-define(TESTED_MODULE, (sut(leap))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


leap_year_test() ->
  ?assert(?TESTED_MODULE:leap_year(1996)).

non_leap_year_test() ->
  ?assertNot(?TESTED_MODULE:leap_year(1997)).

century_test() ->
  ?assertNot(?TESTED_MODULE:leap_year(1900)).

fourth_century_test() ->
  ?assert(?TESTED_MODULE:leap_year(2400)).
