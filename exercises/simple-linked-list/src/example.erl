-module(example).

-export([cons/2, count/1, empty/0, from_native_list/1,
   head/1, reverse/1, tail/1, to_native_list/1]).

empty() -> empty.

cons(Elt, List) -> {Elt, List}.

head({Head, _Tail}) -> Head.

tail({_Head, Tail}) -> Tail.

reverse(List) -> reverse(List, empty).

reverse(empty, Acc) -> Acc;
reverse({Head, Tail}, Acc) ->
    reverse(Tail, cons(Head, Acc)).

count(empty) -> 0;
count({_Head, Tail}) -> 1 + count(Tail).

to_native_list(List) ->
    to_native_list_acc(List, []).

to_native_list_acc(empty, Acc) -> lists:reverse(Acc);
to_native_list_acc({Head, Tail}, Acc) ->
  to_native_list_acc(Tail, [Head|Acc]).

from_native_list(NList) ->
  lists:foldr(fun (Val, List) -> {Val, List} end,
  empty, NList).
