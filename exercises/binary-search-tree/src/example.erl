-module(example).

-export([empty/0, value/1, left/1, right/1, insert/2, to_list/1]).

empty() -> empty.

value({V,_,_}) -> V.

left({_, L,_}) -> L.

right({_, _, R}) -> R.

insert(empty, V) -> {V, empty, empty};
insert({V1, L, R}, V2) when V1 < V2 -> {V1, L, insert(R, V2)};
insert({V1, L, R}, V2) when V1 >= V2 -> {V1, insert(L, V2), R}.

to_list(empty) -> []; 
to_list({V, L, R}) -> to_list(L) ++ [V] ++ to_list(R).