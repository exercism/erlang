-module(strain_tests).

-define(TESTED_MODULE, (sut(strain))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


empty_keep_test() ->
  ?assertEqual([], ?TESTED_MODULE:keep(fun(X) -> X < 10 end, [])).

keep_everything_test() ->
  ?assertEqual([1, 2, 3], ?TESTED_MODULE:keep(fun(X) -> X < 10 end, [1,2,3])).

keep_first_last_test() ->
  ?assertEqual([1, 3], ?TESTED_MODULE:keep(fun(X) -> odd(X) end, [1,2,3])).

keep_nothin_test() ->
  ?assertEqual([], ?TESTED_MODULE:keep(fun(X) -> even(X) end, [1,3,5,7])).

keep_neither_first_nor_last_test() ->
  ?assertEqual([2], ?TESTED_MODULE:keep(fun(X) -> even(X) end, [1,2,3])).

keep_strings_test() ->
  Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
  ?assertEqual(
     ["zebra", "zombies", "zealot"],
     ?TESTED_MODULE:keep(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str)).

empty_discard_test() ->
  ?assertEqual([], ?TESTED_MODULE:discard(fun(X) -> X < 10 end, [])).

discard_everything_test() ->
  ?assertEqual([], ?TESTED_MODULE:discard(fun(X) -> X < 10 end, [1,2,3])).

discard_first_and_last_test() ->
  ?assertEqual([2], ?TESTED_MODULE:discard(fun(X) -> odd(X) end, [1,2,3])).

discard_nothing_test() ->
  ?assertEqual([1, 3, 5, 7], ?TESTED_MODULE:discard(fun(X) -> even(X) end, [1,3,5,7])).

discard_neither_first_nor_last_test() ->
  ?assertEqual([1, 3], ?TESTED_MODULE:discard(fun(X) -> even(X) end, [1,2,3])).

discard_strings_test() ->
  Str = ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"],
  ?assertEqual(
     ["apple", "banana", "cherimoya"],
     ?TESTED_MODULE:discard(fun(S) -> string:sub_string(S, 1,1) =:= "z" end, Str)).

odd(N) -> N rem 2 > 0.

even(N) -> N rem 2 =:= 0.
