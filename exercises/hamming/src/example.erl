-module(example).

-export([hamming_distance/2]).

hamming_distance(From, To) ->
  Comparisons = lists:zipwith(fun(X,Y) -> case X =:= Y of
                                            true -> 0;
                                            false -> 1
                                          end
                              end,
                              From, To),
  lists:sum(Comparisons).
