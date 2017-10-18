-module(testgen).

%% API exports
-export([main/1]).

-include_lib("kernel/include/file.hrl").

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main([]) ->
    io:format("Searching for git basedir~n"),
    {ok, PWD} = file:get_cwd(),
    case find_git(PWD) of
        {ok, GitDir} -> main([GitDir]);
        error -> io:format("No git basedir found, please specifiy manually~n")
    end;
main([GitPath]) ->
    io:format("Using ~s as basepath~n", [GitPath]).

%%====================================================================
%% Internal functions
%%====================================================================

find_git("") ->
    error;
find_git(Dir) ->
    io:format("Checking ~s~n", [Dir]),
    case file:read_file_info(Dir ++ "/.git") of
        {ok, #file_info{type=directory}} ->
            {ok, Dir};

        _ ->
            Parent = tg_file_tools:parent_dir(Dir),
            find_git(Parent)
    end.
