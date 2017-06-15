-module(example).

-export([steps/1,
         test_version/0]).

steps(N) when N =< 0 -> {error, "Only strictly positive numbers are allowed"};
steps(N) ->
  steps(N, 0).

test_version() ->
  1.



steps(1, Acc) -> Acc;
steps(N, Acc) when N rem 2 =:= 0 -> steps(N div 2, Acc + 1);
steps(N, Acc) -> steps(3 * N + 1, Acc + 1).