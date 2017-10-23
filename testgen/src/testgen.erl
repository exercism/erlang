-module(testgen).

%% API exports
-export([main/1]).

-include("tgen.hrl").

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(Args) ->
    Config = process_args(Args, #{}),
    execute(Config).

%%====================================================================
%% Internal functions
%%====================================================================

process_args([], Config = #{path := _, spec_path := _, out_path := _}) ->
    case maps:is_key(exercises, Config) of
        false -> maps:put(exercises, all, Config);
        true -> Config
    end;
process_args([], Config = #{path := Path}) ->
    Config1 = case maps:is_key(spec_path, Config) of
        false -> maps:put(spec_path, iolist_to_binary([Path, "/canonical_data/exercises"]), Config);
        true -> Config
    end,

    Config2 = case maps:is_key(out_path, Config1) of
        false -> maps:put(out_path, iolist_to_binary([Path, "/exercises"]), Config1);
        true -> Config1
    end,

    Config2;
process_args([], Config) ->
    Config1 = case maps:is_key(path, Config) and not (maps:is_key(out_path, Config) or maps:is_key(spec_path, Config)) of
        false -> maps:put(path, search_git_upwards(), Config);
        true -> Config
    end,

    Config2 = case maps:is_key(command, Config1) of
        false -> maps:put(command, "generate", Config1);
        true -> Config1
    end,

    process_args([], Config2);
process_args(["--path", Path|Args], Config) ->
    process_args(Args, maps:put(path, Path, Config));
process_args(["--spec-path", SpecPath|Args], Config) ->
    process_args(Args, maps:put(spec_path, SpecPath, Config));
process_args(["--out-path", OutPath|Args], Config) ->
    process_args(Args, maps:put(out_path, OutPath, Config));
process_args([Arg|Args], Config) ->
    Config1 = case maps:is_key(command, Config) of
        false ->
            maps:put(command, Arg, Config);
        true ->
            maps:update_with(exercises, fun(Tail) -> [Arg|Tail] end, [Arg], Config)
    end,
    process_args(Args, Config1).

search_git_upwards() ->
    {ok, PWD} = file:get_cwd(),
    case tg_git_tools:find_git(PWD) of
        {ok, GitDir} -> GitDir;
        error -> error
    end.

execute(#{command := "generate", spec_path := SpecPath, out_path := OutPath}) ->
    SpecPathStr = binary_to_list(SpecPath),
    OutPathStr = binary_to_list(OutPath),
    SpecFiles0 = filelib:wildcard("*/canonical-data.json", SpecPathStr),
    SpecFiles1 = lists:filtermap(fun filter_by_generator_and_create_record/1, SpecFiles0),
    SpecFiles2 = lists:map(fun(TGen) -> TGen#tgen{path = SpecPathStr ++ "/" ++ TGen#tgen.path, dest = OutPathStr ++ "/" ++ TGen#tgen.name} end, SpecFiles1),
    lists:map(fun tgen:generate/1, SpecFiles2).


filter_by_generator_and_create_record(Path) ->
    Name = tg_file_tools:extract_name(Path),
    case tgen:check(Name) of
        {true, Module} ->
            {true, #tgen{
                module = Module,
                name   = Name,
                path   = Path
            }};
        _ -> false
    end.
