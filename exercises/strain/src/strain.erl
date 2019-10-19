-module(strain).

-export([keep/2, discard/2]).

-spec keep(fun((A) -> boolean()), [A]) -> [A] when A :: term().

keep(_Fn, _List) ->
  undefined.

-spec discard(fun((A) -> boolean()), [A]) -> [A] when A :: term().

discard(_Fn, _List) ->
  undefined.
