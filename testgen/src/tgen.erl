-module(tgen).

-export([
    check/1,
    generate/1
]).

-include("tgen.hrl").

-type tgen() :: #tgen{}.

-callback available() -> boolean().
-callback generate(jsx:json_term()) -> {ok, string()} | {error, atom()}.

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
            process_json(Generator, Content)
    end.

process_json(G = #tgen{name = GName}, Content) when is_list(GName) ->
    process_json(G#tgen{name = list_to_binary(GName)}, Content);
process_json(#tgen{name = GName}, Content) ->
    case jsx:decode(Content, [return_maps, {labels, atom}]) of
        JSON = #{exercise := GName} ->
            io:format("Parsed JSON: ~p~n", [JSON]);
        #{exercise := Name} ->
            io:format("Name in JSON (~p) and name for generator (~p) do not line up", [Name, GName])
    end.