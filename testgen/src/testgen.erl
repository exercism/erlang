-module(testgen).

%% API exports
-export([main/1]).

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
    io:format("Using ~s as basepath~n", [GitPath]).

%%====================================================================
%% Internal functions
%%====================================================================
