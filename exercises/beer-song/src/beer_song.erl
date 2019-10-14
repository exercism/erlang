-module(beer_song).

-export([verse/1, sing/1, sing/2]).

-spec verse(integer()) -> string().

verse(_N) ->
  undefined.

-spec sing(integer()) -> [string()].

sing(_N) ->
  undefined.

-spec sing(From :: integer(), To :: integer()) -> [string()].

sing(_From, _To) ->
  undefined.
