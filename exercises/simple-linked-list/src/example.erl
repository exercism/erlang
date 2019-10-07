-module(example).

-export([cons/2, count/1, empty/0, from_array/1, head/1,
	 reverse/1, tail/1, to_array/1]).

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

to_array(List) ->
    A = array:new(), to_array_loop(0, List, A).

to_array_loop(_, empty, A) -> A;
to_array_loop(Idx, {Head, Tail}, A) ->
    A2 = array:set(Idx, Head, A),
    to_array_loop(Idx + 1, Tail, A2).

from_array(Arr) ->
    array:foldr(fun (_Idx, Val, List) -> {Val, List} end,
		empty, Arr).
