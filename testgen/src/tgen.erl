-module(tgen).

-export([
    check/1,
    generate/1,
    to_test_name/1
]).

-export_type([
    tgen/0,
    exercise_json/0
]).

-include("tgen.hrl").

-type tgen() :: #tgen{}.

-type exercise_json() :: #{
    description := binary(),
    expected    := jsx:json_term(),
    property    := binary(),
    binary()    => jsx:json_term()
}.

-callback available() -> boolean().
-callback generate_test(exercise_json()) -> {ok, string()} | {error, atom()}.


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
process_json(#tgen{name = GName, module = Module}, Content) ->
    case jsx:decode(Content, [return_maps, {labels, attempt_atom}]) of
        JSON = #{exercise := GName, cases := Cases} ->
            io:format("Parsed JSON: ~p~n", [JSON]),
            Tests = lists:map(fun Module:generate_test/1, Cases),
            io:format("Teststuff: ~p~n", [Tests]),
            ModuleContent = generate_module(binary_to_list(GName), Tests, <<"2">>),
            io:format("module content: ~n~s~n", [ModuleContent]);
        #{exercise := Name} ->
            io:format("Name in JSON (~p) and name for generator (~p) do not line up", [Name, GName])
    end.



-spec to_test_name(string() | binary()) -> string() | binary().
to_test_name(Name) when is_binary(Name) ->
    list_to_binary(to_test_name(binary_to_list(Name)));
to_test_name(Name) when is_list(Name) ->
    slugify(Name) ++ "_test".

slugify(Name) when is_binary(Name) ->
        list_to_binary(slugify(binary_to_list(Name)));
slugify(Name) when is_list(Name) ->
    lists:filtermap(fun
        (C) when (($a =< C) and (C =< $z)) or (C == $_) -> {true, C};
        (C) when (($A =< C) and (C =< $Z)) -> {true, C - $A + $a};
        (C) when (C == $\s) or (C == $-)-> {true, $_};
        (_) -> false
    end, Name).

generate_module(ModuleName, Tests, Version) ->
    SluggedModName = slugify(ModuleName),
    [<<"-module('">>, SluggedModName, <<"_tests').\n">>,
     <<"\n">>,
     <<"-define(TESTED_MODULE, (sut('">>, SluggedModName, <<"'))).\n">>,
     <<"-define(TEST_VERSION, 2).\n">>,
     <<"-include(\"exercism.hrl\").\n">>,
     <<"\n">>,
     <<"\n">>] ++ lists:map(fun to_binary/1, Tests).

to_binary(#{testname := Name, testimpl := Impl}) ->
    [Name, <<"() ->\n">>,
     impl(Impl, <<"    ">>), "."].

impl({Call, Args}, Indent) ->
    [Indent, Call].