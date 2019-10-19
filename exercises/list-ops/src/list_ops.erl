-module(list_ops).

-export([append/2, concat/1, filter/2, length/1, map/2, foldl/3, foldr/3,
	 reverse/1]).

-spec append([T], [T]) -> [T] when T :: term().

append(_List1, _List2) -> undefined.

-spec concat([Thing]) -> list() when Thing :: atom() | integer() | float() | string().

concat(_List) -> undefined.

-spec filter(fun((T) -> boolean()), [T]) -> [T] when T :: term().

filter(_Function, _List) -> undefined.

-spec length(list()) -> integer().

length(_List) -> undefined.

-spec map(fun((A)-> B), [A]) -> [B] when A :: B :: term().

map(_Function, _List) -> undefined.

-spec foldl(fun((Elem, AccIn) -> AccOut), Acc0, [Elem]) -> Acc1 when
      Acc0 :: term(),
      Acc1 :: term(),
      AccIn :: term(),
      AccOut :: term(),
      Elem :: term().

foldl(_Function, _Start, _List) -> undefined.

-spec foldr(fun((Elem, AccIn) -> AccOut), Acc0, [Elem]) -> Acc1 when
      Acc0 :: term(),
      Acc1 :: term(),
      AccIn :: term(),
      AccOut :: term(),
      Elem :: term().

foldr(_Function, _Start, _List) -> undefined.

-spec reverse([T]) -> [T] when T :: term().

reverse(_List) -> undefined.
