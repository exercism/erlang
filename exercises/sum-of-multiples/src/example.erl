-module(example).

-export([sum/2]).

-import(lists, [foldl/3, seq/2, any/2]).

sum(Multiples, A) ->
  foldl(fun(X, Sum) -> case multiple(Multiples, X) of
                         true -> Sum + X;
                         false -> Sum
                       end
        end,
        0,
        seq(1, A-1)).



multiple(List, X) ->
  any(fun(E) -> E/=0 andalso (X rem E) =:= 0 end, List).
