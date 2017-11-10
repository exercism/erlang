-module(two_fer_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

say_you_test() ->
  ?assertEqual("One for you, one for me.", two_fer:two_fer()).

say_alice_test() ->
  ?assertEqual("One for Alice, one for me.", two_fer:two_fer("Alice")).

say_bob_test() ->
  ?assertEqual("One for Bob, one for me.", two_fer:two_fer("Bob")).

version_test() ->
  ?assertMatch(1, two_fer:test_version()).
