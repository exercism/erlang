-module(example).

-export([empty/0, data/1, left/1, right/1, insert/2, sorted_data/1]).

empty() -> empty.

data({V,_,_}) -> V.

left({_, L,_}) -> L.

right({_, _, R}) -> R.

insert(empty, V) -> {V, empty, empty};
insert({V1, L, R}, V2) when V1 < V2 -> {V1, L, insert(R, V2)};
insert({V1, L, R}, V2) when V1 >= V2 -> {V1, insert(L, V2), R}.

sorted_data(empty) -> []; 
sorted_data({V, L, R}) -> sorted_data(L) ++ [V] ++ sorted_data(R).
