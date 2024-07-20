-module(strain_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

empty_keep_test() ->
  ?assertEqual([], strain:keep(fun(X) -> X < 10 end, [])).

keep_everything_test() ->
  ?assertEqual([1, 2, 3], strain:keep(fun(X) -> X < 10 end, [1,2,3])).

keep_first_last_test() ->
  ?assertEqual([1, 3], strain:keep(fun(X) -> odd(X) end, [1,2,3])).

keep_nothing_test() ->
  ?assertEqual([], strain:keep(fun(X) -> even(X) end, [1,3,5,7])).

keep_neither_first_nor_last_test() ->
  ?assertEqual([2], strain:keep(fun(X) -> even(X) end, [1,2,3])).

keep_strings_test() ->
  Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
  ?assertEqual(
     ["zebra", "zombies", "zealot"],
     strain:keep(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str)).

keep_lists_test() ->
  List = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]],
  ?assertEqual(
     [[5, 5, 5], [5, 1, 2], [1, 5, 2], [1, 2, 5]],
     strain:keep(fun(L) -> lists:member(5, L) end, List)).

empty_discard_test() ->
  ?assertEqual([], strain:discard(fun(X) -> X < 10 end, [])).

discard_everything_test() ->
  ?assertEqual([], strain:discard(fun(X) -> X < 10 end, [1,2,3])).

discard_first_and_last_test() ->
  ?assertEqual([2], strain:discard(fun(X) -> odd(X) end, [1,2,3])).

discard_nothing_test() ->
  ?assertEqual([1, 3, 5, 7], strain:discard(fun(X) -> even(X) end, [1,3,5,7])).

discard_neither_first_nor_last_test() ->
  ?assertEqual([1, 3], strain:discard(fun(X) -> even(X) end, [1,2,3])).

discard_strings_test() ->
  Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
  ?assertEqual(
     ["apple", "banana", "cherimoya"],
     strain:discard(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str)).

discard_lists_test() ->
  List = [[1, 2, 3], [5, 5, 5], [5, 1, 2], [2, 1, 2], [1, 5, 2], [2, 2, 1], [1, 2, 5]],
  ?assertEqual(
     [[1, 2, 3], [2, 1, 2], [2, 2, 1]],
     strain:discard(fun(L) -> lists:member(5, L) end, List)).

odd(N) -> N rem 2 > 0.

even(N) -> N rem 2 =:= 0.
