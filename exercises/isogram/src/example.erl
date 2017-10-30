-module(example).

-export([is_isogram/1, test_version/0]).

is_isogram(String) ->
    check_isogram(string:to_lower(String)).

check_isogram("") ->
    true;
check_isogram([H|T]) ->
    B = is_alpha(H) andalso is_found_in(H, T),
    not B andalso check_isogram(T).

is_alpha(C) when ($a =< C), (C =< $z) ->
    C /= string:to_upper(C);
is_alpha(_) ->
    false.

is_found_in(C, S) when ($a =< C), (C =< $z) ->
    lists:any(fun(X) -> X == C end, S);
is_found_in(_, _) ->
    false.

test_version() -> 1.
