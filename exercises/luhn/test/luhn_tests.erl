-module(luhn_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(luhn))).

invalid_test() ->
  ?assertNot(?TESTED_MODULE:valid("1111")),
  ?assertNot(?TESTED_MODULE:valid("738")).

valid_test() ->
  ?assert(?TESTED_MODULE:valid("8739567")),
  ?assert(?TESTED_MODULE:valid("8763")),
  ?assert(?TESTED_MODULE:valid("2323 2005 7766 3554")).

create_test() ->
  ?assertEqual("2323 2005 7766 3554", ?TESTED_MODULE:create("2323 2005 7766 355")).
