-module(example).

-export([sumOfMultiples/2]).

-import(lists, [foldl/3, seq/2, any/2]).

-spec sumOfMultiples([pos_integer()], pos_integer()) -> non_neg_integer().
sumOfMultiples(Multiples, A) ->
  foldl(fun(X, Sum) -> case multiple(Multiples, X) of
                         true -> Sum + X;
                         false -> Sum
                       end
        end,
        0,
        seq(1, A-1)).

multiple(List, X) ->
  any(fun(E) -> (X rem E) =:= 0 end, List).
