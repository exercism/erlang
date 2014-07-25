-module(strain_test).

-include_lib("eunit/include/eunit.hrl").

empty_keep_test() ->
    ?assertEqual(strain:keep(fun(X) -> X < 10 end, []), []).

keep_everything_test() ->
    ?assertEqual(strain:keep(fun(X) -> X < 10 end, [1,2,3]), [1,2,3]).

keep_first_last_test() ->
    ?assertEqual(strain:keep(fun(X) -> odd(X) end, [1,2,3]), [1,3]).

keep_nothin_test() ->
    ?assertEqual(strain:keep(fun(X) -> even(X) end, [1,3,5,7]), []).

keep_neither_first_nor_last_test() ->
    ?assertEqual(strain:keep(fun(X) -> even(X) end, [1,2,3]), [2]).

keep_strings_test() ->
    Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
    ?assertEqual(strain:keep(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str), ["zebra", "zombies", "zealot"]).

empty_discard_test() ->
    ?assertEqual(strain:discard(fun(X) -> X < 10 end, []), []).

discard_everything_test() ->
    ?assertEqual(strain:discard(fun(X) -> X < 10 end, [1,2,3]), []).

discard_first_and_last_test() ->
    ?assertEqual(strain:discard(fun(X) -> odd(X) end, [1,2,3]), [2]).

discard_nothing_test() ->
    ?assertEqual(strain:discard(fun(X) -> even(X) end, [1,3,5,7]), [1,3,5,7]).

discard_neither_first_nor_last_test() ->
    ?assertEqual(strain:discard(fun(X) -> even(X) end, [1,2,3]), [1,3]).

discard_strings_test() ->
    Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
    ?assertEqual(strain:discard(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str), ["apple", "banana", "cherimoya"]).

odd(N) -> N rem 2 > 0.

even(N) -> N rem 2 =:= 0.
