-module(example).
-export([test_version/0,make/1]).

test_version() -> 1.

make(N) ->
    Self = self(),
    Rows = Cols = lists:seq(1,N),
    lists:foreach(
      fun(Y) ->
              spawn_link(fun() ->
                                 Self ! {Y, [n(X,Y,N)||X<-Cols]}
                         end)
      end, Rows),
    lists:map(fun(Y) ->
                      receive
                          {Y, L} -> L
                      end
              end, Rows).

n(0,1,_)                        -> 0;
n(X,Y,N) when Y=:=X+1, X+Y=<N+1 -> n(X-1, Y-1, N) + 4*(N - 2*X + 1);
n(X,Y,N) when X+Y=<N+1, X-Y>=0  -> n(Y-1, Y, N) + X-Y+1;
n(X,Y,N) when X+Y>N+1, X-Y>=0   -> n(X, N+1-X, N) + X+Y-N-1;
n(X,Y,N) when X+Y>=N+1          -> n(Y, Y, N) + Y-X;
n(X,Y,N)                        -> n(X, N-X+1, N) + N+1-X-Y.
