-module(example).
-export([two_fer/1, test_version/0]).

two_fer(Name) ->
  case Name of
    "" ->
      "One for you, one for me.";
    _ ->
      "One for " ++ Name ++ ", one for me."
  end.

test_version() ->
  1.
