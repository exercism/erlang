-module(leap_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(leap))).

leap_year_test() ->
  ?assert(?TESTED_MODULE:leap_year(1996)).

non_leap_year_test() ->
  ?assertNot(?TESTED_MODULE:leap_year(1997)).

century_test() ->
  ?assertNot(?TESTED_MODULE:leap_year(1900)).

fourth_century_test() ->
  ?assert(?TESTED_MODULE:leap_year(2400)).
