-module(example).

-export([egg_count/1]).


egg_count(Number) -> egg_count(Number, 0).

egg_count(0, Acc) -> Acc;
egg_count(Number, Acc) when Number > 0 ->
    egg_count(Number bsr 1, Acc + (Number band 1)).
