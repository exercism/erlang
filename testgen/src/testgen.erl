-module(testgen).

%% API exports
-export([main/1]).

-include("tgen.hrl").

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(Args) ->
    {ok, _} = application:ensure_all_started(testgen),
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

    process_args([], Config2);
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

execute(Config = #{command := "generate", spec_path := SpecPath, exercises := all}) ->
    SpecFiles = filelib:wildcard("*/canonical-data.json", binary_to_list(SpecPath)),
    Exercises = lists:map(fun tg_file_tools:extract_name/1, SpecFiles),
    put(log_unavailable, false), % TODO: Get rid of the use of the process dictionary!
    execute(maps:put(exercises, Exercises, Config));
execute(#{command := "generate", spec_path := SpecPath, out_path := OutPath, exercises := [_|_] = Exercises}) ->
    case get(log_unavailable) of % TODO: Get rid of the use of the process dictionary!
        undefined -> put(log_unavailable, true);
        _ -> ok
    end,
    {ok, Modules} = application:get_key(testgen, modules),
    Generators0   = lists:filter(generator_module(Exercises), Modules),
    ok            = code:atomic_load(Generators0),
    Generators1   = lists:map(create_record(SpecPath), Generators0),
    Generators2   = lists:map(fun (Generator) -> Generator#tgen{dest = iolist_to_binary([OutPath, $/, Generator#tgen.name])} end, Generators1),
    Contents      = lists:map(fun tgen:generate/1, Generators2),
    lists:map(
        fun (Xs = [#{exercise := ExName}|_]) ->
            io:format("Writing ~s", [ExName]),
            lists:map(fun
                (#{exercise := GName, name := Name, folder := Folder, content := Content}) ->
                    Path = lists:flatten(io_lib:format("~s/~s/~s/~s.erl", [OutPath, GName, Folder, Name])),
                    case file:open(Path, [write]) of
                        {ok, IODevice} ->
                            io:format(IODevice, "~s", [Content]),
                            file:close(IODevice);
                        {error, Reason} ->
                            io:format("Can not open ~p for writing because of ~p.~n", [Path, Reason])
                    end
                end, Xs),
            io:format(", finished~n");
        ({error, Reason, Path}) ->
            io:format("Can not open ~p for reading because of ~p.~n", [Path, Reason])
        end, Contents);
execute(#{command := "check"}) ->
    io:format("This command has not been implemented yet~n");
execute(#{command := "help"}) ->
    io:format("This command has not been implemented yet~n");
execute(_) ->
    io:format("Unknown command. Only generate is available right now.~n").


create_record(SpecPath) ->
    fun (Module) ->
        "tgen_" ++ Name = atom_to_list(Module),
        Path = filename:join([SpecPath, Name, "canonical-data.json"]),
        #tgen{
            module = Module,
            name   = Name,
            path   = Path
        }
    end.

generator_module(Exercises) ->
    fun F(Mod) when is_atom(Mod) -> F(atom_to_list(Mod));
        F("tgen_" ++ Ex) -> lists:member(Ex, Exercises);
        F(_) -> false
    end.
