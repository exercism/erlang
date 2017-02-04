-module(example).
-export([accumulate/2, test_version/0]).

%%
%% given a fun and a list, apply fun to each list item replacing list item with fun's return value.
%%
-spec accumulate(fun((A) -> B), list(A)) -> list(B).
accumulate(Fn, List)       -> accumulate(List, Fn, []).

accumulate([H|T], Fn, Out) -> accumulate(T, Fn, [Fn(H) | Out]);
accumulate([], _Fn, Out)   -> lists:reverse(Out).

test_version() ->
    1.
