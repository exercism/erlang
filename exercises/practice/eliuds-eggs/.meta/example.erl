-module(eliuds_eggs).

-export([eggCount/1]).


eggCount(Number) -> eggCount(Number, 0).

eggCount(0, Acc) -> Acc;
eggCount(Number, Acc) when Number > 0 ->
    eggCount(Number bsr 1, Acc + (Number band 1)).
