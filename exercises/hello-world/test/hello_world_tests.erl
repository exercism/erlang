-module(hello_world_tests).

-define(TESTED_MODULE, (sut(hello_world))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


no_name_test() ->
  ?assertEqual("Hello, World!", ?TESTED_MODULE:greet()).

alice_test() ->
  ?assertEqual("Hello, Alice!", ?TESTED_MODULE:greet("Alice")).

bob_test() ->
  ?assertEqual("Hello, Bob!", ?TESTED_MODULE:greet("Bob")).

strange_test() ->
  ?assertEqual("Hello, !", ?TESTED_MODULE:greet("")).
