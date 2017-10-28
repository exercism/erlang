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
-callback version() -> string().
-callback generate_test(exercise_json()) ->
    {ok,
        erl_syntax:syntax_tree() | [erl_syntax:syntax_tree()],
        [{string() | binary(), non_neg_integer()}]}.


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
    io:format("Generating ~s", [Generator#tgen.name]),
    case file:read_file(Generator#tgen.path) of
        {ok, Content} ->
            Files = process_json(Generator, Content),
            io:format(", finished~n"),
            Files;
        {error, Reason} ->
            io:format(", failed (~p)~n", [Reason]),
            {error, Reason, Generator#tgen.path}
    end.

process_json(G = #tgen{name = GName}, Content) when is_list(GName) ->
    process_json(G#tgen{name = list_to_binary(GName)}, Content);
process_json(#tgen{name = GName, module = Module}, Content) ->
    case jsx:decode(Content, [return_maps, {labels, attempt_atom}]) of
        _JSON = #{exercise := GName, cases := Cases} ->
            % io:format("Parsed JSON: ~p~n", [JSON]),
            {TestImpls, Props} = lists:foldl(fun (Spec, {Tests, OldProperties}) ->
                {ok, Test, Properties} = Module:generate_test(Spec),
                {[Test|Tests], combine(OldProperties, Properties)}
            end, {[], []}, Cases),
            {TestModuleName, TestModuleContent} = generate_test_module(binary_to_list(GName), TestImpls, Module:version()),
            {StubModuleName, StubModuleContent} = generate_stub_module(binary_to_list(GName), Props, Module:version()),

            [#{exercise => GName, name => TestModuleName, folder => "test", content => io_lib:format("~s", [TestModuleContent])},
             #{exercise => GName, name => StubModuleName, folder => "src",  content => io_lib:format("~s", [StubModuleContent])}];
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

generate_stub_module(ModuleName, Props, Version) ->
    SluggedModName = slugify(ModuleName),
    VersionName = "test_version",
    Props1 = Props ++ [{VersionName, []}],

    Funs = lists:map(fun ({Name, []}) ->
            tgs:simple_fun(Name, [tgs:atom(undefined)])
        end, Props) ++ [
            tgs:simple_fun(VersionName, [tgs:raw(Version)])],

    Abstract = [
        tgs:module(SluggedModName),
        nl,
        tgs:export(Props1),
        nl,
        nl
    ] ++ inter(nl, Funs),

    {SluggedModName, lists:flatten(
        lists:map(
            fun (nl) -> io_lib:format("~n", []);
                (Tree) -> io_lib:format("~s~n", [erl_prettypr:format(Tree)])
            end, Abstract))}.

generate_test_module(ModuleName, Tests, Version) ->
    SluggedModName = slugify(ModuleName),

    Abstract = [
        tgs:module(SluggedModName ++ "_tests"),
        nl,
        tgs:define("TESTED_MODULE",
            tgs:parens(
                tgs:call_fun("sut", [tgs:atom(SluggedModName)]))),
        tgs:define("TEST_VERSION", erl_syntax:text(Version)),
        tgs:include("exercism.hrl"),
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

combine(List, []) -> List;
combine(List, [{Name, Arity}|Xs]) when is_list(Name) ->
    combine(List, [{list_to_binary(Name), Arity}|Xs]);
combine(List, [{Name, _} = X|Xs]) when is_binary(Name) ->
    List1 = insert(List, X),
    combine(List1, Xs).

insert([], X) -> [X];
insert([X|_] = Xs, X) -> Xs;
insert([X|XS], Y) when X < Y -> [X|insert(XS, Y)];
insert([X|XS], Y) when X > Y -> [Y, X|XS].
