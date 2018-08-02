-module(beer_song).

-export([verse/1, sing/1, sing/2, test_version/0]).

verse(_N) ->
  undefined.

sing(_N) ->
  undefined.

sing(_From, _To) ->
  undefined.

test_version() -> 1.
