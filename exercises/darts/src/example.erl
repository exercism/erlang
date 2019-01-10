-module(example).

-export([score/2]).


score(X, Y) when X*X+Y*Y=<1 -> 10;
score(X, Y) when X*X+Y*Y=<25 -> 5;
score(X, Y) when X*X+Y*Y=<100 -> 1;
score(_, _) -> 0.
