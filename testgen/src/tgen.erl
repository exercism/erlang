-module(tgen).

-export([
    check/1,
    generate/1
]).

-include("tgen.hrl").

-type tgen() :: #tgen{}.

-callback available() -> boolean().

-spec check(string()) -> {true, atom()} | false.
check(Name) ->
    Module = list_to_atom("tgen_" ++ Name),
    try Module:available() of
        true -> {true, Module};
        false -> false
    catch
        _:_ -> false
    end.

-spec generate(tgen()) -> ok. 
generate(Generator = #tgen{}) ->
    io:format("Generating ~s~n", [Generator#tgen.name]),
    case file:read_file(Generator#tgen.path) of
        {ok, Content} ->
            JSON = jsx:decode(Content, [return_maps, {labels, atom}]),
            io:format("Parsed JSON: ~p~n", [JSON])
    end.
