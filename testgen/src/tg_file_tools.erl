-module(tg_file_tools).

-export([
    extract_name/1,
    parent_dir/1
]).

extract_name(Name) ->
    lists:takewhile(fun(C) -> not lists:member(C, [$/, $\\]) end, Name).

parent_dir(Dir) ->
    DirRev0 = lists:reverse(Dir),
    DirRev1 = lists:dropwhile(fun(C) -> not lists:member(C, [$/, $\\]) end, DirRev0),
    lists:reverse(tl(DirRev1)).
