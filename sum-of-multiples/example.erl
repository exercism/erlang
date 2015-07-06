-module(sum_of_multiples).

-export([sumOfMultiplesDefault/1, sumOfMultiples/2]).

-import(lists, [foldl/3, seq/2, any/2]).

-spec sumOfMultiplesDefault(pos_integer()) -> non_neg_integer().
sumOfMultiplesDefault(A) ->
  sumOfMultiples([3,5], A).

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
