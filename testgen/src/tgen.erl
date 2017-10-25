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

-type canonical_data() :: #{
    exercise := binary(),
    version  := binary(),
    cases    := exercise_json()
}.

-type exercise_json() :: #{
    description := binary(),
    expected    := jsx:json_term(),
    property    := binary(),
    binary()    => jsx:json_term()
}.

-callback available() -> boolean().
-callback init(canonical_data()) -> {ok, term()}.
-callback version(term()) -> string().
-callback generate_test(exercise_json(), term()) -> {ok, erl_syntax:syntax_tree() | [erl_syntax:syntax_tree()]}.


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
            {ModName, TestModule} = process_json(Generator, Content),
            TestfilePath = iolist_to_binary([Generator#tgen.dest, "/test/", ModName, ".erl"]),
            #{
                module => ModName,
                impl   => TestModule,
                path   => TestfilePath
            };
        {error, Reason} ->
            io:format("Not able to open ~s because of ~p.", [Generator#tgen.path, Reason])
    end.

process_json(G = #tgen{name = GName}, Content) when is_list(GName) ->
    process_json(G#tgen{name = list_to_binary(GName)}, Content);
process_json(#tgen{name = GName, module = Module}, Content) ->
    case jsx:decode(Content, [return_maps, {labels, attempt_atom}]) of
        _JSON = #{exercise := GName, cases := Cases} ->
            % io:format("Parsed JSON: ~p~n", [JSON]),
            {TestImpls, _State} = lists:foldl(fun (Spec, {Tests, State}) ->
                {ok, Test, NewState} = Module:generate_test(Spec, State),
                {[Test|Tests], NewState}
            end, {[], undefined}, Cases),
            {ModuleName, ModuleContent} = generate_module(binary_to_list(GName), TestImpls, Module:version(undefined)), % TODO: Read version dynamically and pass as Integer!

            {ModuleName, io_lib:format("~s", [ModuleContent])};
        #{exercise := Name} ->
            io:format("Name in JSON (~p) and name for generator (~p) do not line up", [Name, GName])
    end.



-spec to_test_name(string() | binary()) -> string() | binary().
to_test_name(Name) when is_binary(Name) ->
    to_test_name(binary_to_list(Name));
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

    Abstract = [
        erl_syntax:attribute(
            erl_syntax:text("module"),
            [erl_syntax:atom(SluggedModName ++ "_tests")]),
        nl,
        erl_syntax:attribute(
            erl_syntax:text("define"), [
                erl_syntax:text("TESTED_MODULE"),
                erl_syntax:parentheses(
                    erl_syntax:application(
                        erl_syntax:text("sut"), [
                            erl_syntax:atom(SluggedModName)]))]),
        erl_syntax:attribute(
            erl_syntax:text("define"), [
                erl_syntax:text("TEST_VERSION"),
                erl_syntax:text(Version)]),
        erl_syntax:attribute(
            erl_syntax:text("include"), [
                erl_syntax:abstract("exercism.hrl")]),
        nl,
        nl] ++ inter(nl, Tests),

    {SluggedModName ++ "_tests", lists:flatten(
        lists:map(
            fun (nl) -> io_lib:format("~n", []);
                (Tree) -> io_lib:format("~s~n", [erl_prettypr:format(Tree)])
            end, Abstract))}.

inter(_, []) -> [];
inter(_, [X]) -> [X];
inter(Delim, [X|Xs]) -> [X, Delim|Xs].
