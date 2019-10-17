-module(list_ops).

-export([append/2, concat/1, filter/2, length/1, map/2, foldl/3, foldr/3,
	 reverse/1]).

-spec append(list(), list()) -> list().

append(_List1, _List2) -> undefined.

-spec concat(list(list())) -> list().

concat(_List) -> undefined.

-spec filter(fun((T) -> boolean()), list(T)) -> list(T) when T :: any().

filter(_Function, _List) -> undefined.

-spec length(list()) -> integer().

length(_List) -> undefined.

-spec map(fun((A)-> B), list(A)) -> list(B) when A :: B :: any().

map(_Function, _List) -> undefined.

-spec foldl(fun((Elem, AccIn) -> AccOut), Acc0, list(Elem)) -> Acc1 when
      Acc0 :: term(),
      Acc1 :: term(),
      AccIn :: term(),
      AccOut :: term(),
      Elem :: term().

foldl(_Function, _Start, _List) -> undefined.

-spec foldr(fun((Elem, AccIn) -> AccOut), Acc0, list(Elem)) -> Acc1 when
      Acc0 :: term(),
      Acc1 :: term(),
      AccIn :: term(),
      AccOut :: term(),
      Elem :: term().

foldr(_Function, _Start, _List) -> undefined.

-spec reverse(list()) -> list().

reverse(_List) -> undefined.
