-module(example).

-export([steps/1]).

steps(N) when N =< 0 -> erlang:error(badarg);
steps(N) ->
  steps(N, 0).



steps(1, Acc) -> Acc;
steps(N, Acc) when N rem 2 =:= 0 -> steps(N div 2, Acc + 1);
steps(N, Acc) -> steps(3 * N + 1, Acc + 1).
