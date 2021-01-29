-module(example).

-export([slices/2]).

slices(Width, String) when Width>0, String=/=[], Width=<length(String) ->
    rows(length(String), Width, String);
slices(_, _) ->
    error(badarg).

rows(Length, Width, String=[_|T]) when Length>Width ->
    {Row, _}=lists:split(Width, String),
    [Row|rows(Length-1, Width, T)];
rows(_, _, String) ->
    [String].
