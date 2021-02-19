-module(example).

-export([is_isogram/1]).

is_isogram(String) ->
    check_isogram([C || C <- string:to_lower(String), ($a =< C), (C =< $z)]).

check_isogram("") ->
    true;
check_isogram([H|T]) ->
    is_not_found_in(H, T) andalso check_isogram(T).

is_not_found_in(C, S) ->
    lists:all(fun(X) -> X /= C end, S).
