-module('tgen_hello-world').

-behaviour(tgen).

-export([
    available/0
]).

-spec available() -> true.
available() ->
    true.