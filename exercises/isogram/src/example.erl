-module(example).

-export([is_isogram/1, test_version/0]).

is_isogram(String) ->
    check_isogram(string:to_lower(String)).

check_isogram("") ->
    true;
check_isogram([H|T]) ->
    B = alpha(H) andalso found_in(H, T),
    not B andalso check_isogram(T).

alpha(C_lower) ->
    C_lower /= string:to_upper(C_lower).

found_in(C_lower, S_lower) ->
    lists:any(fun(X) -> X == C_lower end, S_lower).

test_version() -> 1.
