-module(two_fer_tests).

-define(TESTED_MODULE, (sut(two_fer))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


say_you_test() ->
  ?assertEqual("One for you, one for me.", ?TESTED_MODULE:two_fer("")).

say_alice_test() ->
  ?assertEqual("One for Alice, one for me.", ?TESTED_MODULE:two_fer("Alice")).

say_bob_test() ->
  ?assertEqual("One for Bob, one for me.", ?TESTED_MODULE:two_fer("Bob")).