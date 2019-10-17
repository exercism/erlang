-module(strain).

-export([keep/2, discard/2]).

-spec keep(fun((A) -> boolean()), [A]) -> [A] when A :: any().

keep(_Fn, _List) ->
  undefined.

-spec discard(fun((A) -> boolean()), [A]) -> [A] when A :: any().

discard(_Fn, _List) ->
  undefined.
