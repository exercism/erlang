-module(gigasecond_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(gigasecond))).

one_test() ->
  Gs = ?TESTED_MODULE:from({2011, 4, 25}),
  ?assertEqual({{2043, 1, 1}, {1, 46, 40}}, Gs).

two_test() ->
  Gs = ?TESTED_MODULE:from({1977, 6, 13}),
  ?assertEqual({{2009, 2, 19}, {1, 46, 40}}, Gs).

three_test() ->
  Gs = ?TESTED_MODULE:from({1959, 7, 19}),
  ?assertEqual({{1991, 3, 27}, {1, 46, 40}}, Gs).

four_with_seconds_test() ->
  Gs = ?TESTED_MODULE:from({{1959, 7, 19}, {23, 59, 59}}),
  ?assertEqual({{1991, 3, 28}, {1, 46, 39}}, Gs).
