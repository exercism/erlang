-module(accumulate_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

accumulate_squares_test() ->
  Accumulate = sut(accumulate),
  Fn = fun(Number) -> Number * Number end,
  Ls = [1, 2, 3],
  ?assertEqual([1, 4, 9], Accumulate:accumulate(Fn, Ls)).

accumulate_upcases_test() ->
  Accumulate = sut(accumulate),
  Fn = fun(Word) -> string:to_upper(Word) end,
  Ls = string:tokens("hello world", " "),
  ?assertEqual(["HELLO", "WORLD"], Accumulate:accumulate(Fn, Ls)).

accumulate_reversed_strings_test() ->
  Accumulate = sut(accumulate),
  Fn = fun(Word) -> lists:reverse(Word) end,
  Ls = string:tokens("the quick brown fox etc", " "),
  ?assertEqual(["eht", "kciuq", "nworb", "xof", "cte"], Accumulate:accumulate(Fn, Ls)).

accumulate_recursively_test() ->
  Accumulate = sut(accumulate),
  Chars = string:tokens("a b c", " "),
  Nums = string:tokens("1 2 3", " "),
  Fn = fun(Char) -> [Char ++ Num || Num <- Nums] end,
  ?assertEqual([["a1", "a2", "a3"], ["b1", "b2", "b3"], ["c1", "c2", "c3"]], Accumulate:accumulate(Fn, Chars)).
