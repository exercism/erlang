-module(example).

-export([sieve/1, test_version/0]).

sieve(N) when N < 2 ->
    [];
sieve(N) ->
    sieve(lists:seq(2,N), []).

sieve([], P) ->
    lists:reverse(P);
sieve(S, P) ->
    N = hd(S),
    sieve(lists:filter(fun(X) -> X rem N /= 0 end, S), [N|P]).

test_version() -> 1.
