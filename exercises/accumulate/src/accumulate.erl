-module(accumulate).

-export([accumulate/2]).

-spec accumulate(fun((A) -> B), list(A)) -> list(B) when A :: B :: term().

accumulate(_Fn, _Ls) ->
  undefined.
