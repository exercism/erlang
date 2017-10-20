-module(testgen).

%% API exports
-export([main/1]).

-include("tgen.hrl").

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([]) ->
    io:format("Searching for git basedir~n"),
    {ok, PWD} = file:get_cwd(),
    case tg_git_tools:find_git(PWD) of
        {ok, GitDir} -> main([GitDir]);
        error -> io:format("No git basedir found, please specifiy manually~n")
    end;
main([GitPath]) ->
    io:format("Using ~s as basepath~n", [GitPath]),
    SpecFiles0 = filelib:wildcard("canonical_data/exercises/*/canonical-data.json", GitPath),
    SpecFiles1 = lists:filtermap(fun filter_by_generator_and_create_record/1, SpecFiles0),
    SpecFiles2 = lists:map(fun(TGen) -> TGen#tgen{path = GitPath ++ "/" ++ TGen#tgen.path} end, SpecFiles1),
    lists:map(fun tgen:generate/1, SpecFiles2).

%%====================================================================
%% Internal functions
%%====================================================================

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