-module(strain).

-export([keep/2, discard/2]).

-spec keep(fun((any()) -> boolean()), list(any())) -> list(any()).
keep(_F, []) ->
  [];
keep(F, [H|T]) ->
  case F(H) of
    true -> [H|keep(F,T)];
    _ -> keep(F,T)
  end.

-spec discard(fun((any()) -> boolean()), list(any())) -> list(any()).
discard(F, L) ->
  keep(fun(X) -> not(F(X)) end, L).
