-module(example).

-export([factors/1]).


%% only integers >0 are allowed
factors(Value) when not is_integer(Value); Value=<0 ->
    exit(badarg);
%% 1 has no factors
factors(1) ->
    [];
%% numbers >1 have at least one factor
factors(Value) ->
    factors(Value, 2, []).


factors(1, _, Acc) ->
    lists:sort(Acc);
factors(V, N, Acc) when V rem N=:=0 ->
    factors(V div N, N, [N|Acc]);
factors(V, 2, Acc) ->
    factors(V, 3, Acc);
factors(V, N, Acc) ->
    factors(V, N+2, Acc).
