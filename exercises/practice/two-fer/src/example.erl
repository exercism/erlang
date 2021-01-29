-module(example).
-export([two_fer/1, two_fer/0]).

two_fer() ->
    two_fer("you").

two_fer(Name) ->
    io_lib:format("One for ~s, one for me.", [Name]).
