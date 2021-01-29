-module(example).

-export([kind/3]).

kind(A, B, C) when A=<0; B=<0; C=<0 ->
    {error, "all side lengths must be positive"};
kind(A, B, C) when A+B=<C; A+C=<B; B+C=<A ->
    {error, "side lengths violate triangle inequality"};
kind(S, S, S) -> equilateral;
kind(_, S, S) -> isosceles;
kind(S, _, S) -> isosceles;
kind(S, S, _) -> isosceles;
kind(_, _, _) -> scalene.
