-module(tg_git_tools).

-export([
    find_git/1
]).

-include_lib("kernel/include/file.hrl").

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