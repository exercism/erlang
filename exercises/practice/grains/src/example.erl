-module(example).
-export([square/1, total/0]).

square(N) when N>=1, N=<64 ->
  square(N, 1);
square(_) ->
  {error, "square must be between 1 and 64"}.

square(1, Acc) ->
  Acc;
square(N, Acc) ->
  square(N - 1, Acc * 2).

total() ->
  % Not the most efficient, but is passes.
  lists:foldl(fun(Elem, Acc) -> square(Elem) + Acc end,
              0,
              lists:seq(1, 64)).
