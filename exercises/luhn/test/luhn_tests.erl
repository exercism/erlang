-module(luhn_tests).

-define(TESTED_MODULE, (sut(luhn))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


invalid_test() ->
  ?assertNot(?TESTED_MODULE:valid("1")),
  ?assertNot(?TESTED_MODULE:valid("0")),
  ?assertNot(?TESTED_MODULE:valid("055 444 286")),
  ?assertNot(?TESTED_MODULE:valid("8273 1232 7352 0569")),
  ?assertNot(?TESTED_MODULE:valid("055a 444 285")),
  ?assertNot(?TESTED_MODULE:valid("055-444-285")),
  ?assertNot(?TESTED_MODULE:valid("055£ 444$ 285")),
  ?assertNot(?TESTED_MODULE:valid(" 0")).

valid_test() ->
  ?assert(?TESTED_MODULE:valid("059")),
  ?assert(?TESTED_MODULE:valid("59")),
  ?assert(?TESTED_MODULE:valid("055 444 285")),
  ?assert(?TESTED_MODULE:valid("0000 0")),
  ?assert(?TESTED_MODULE:valid("091")).

create_test() ->
  ?assertEqual("2323 2005 7766 3554", ?TESTED_MODULE:create("2323 2005 7766 355")).
