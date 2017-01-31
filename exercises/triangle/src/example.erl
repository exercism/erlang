-module(example).

-export([kind/3]).

kind(A,B,C) when (A =< 0) or (B =< 0) or (C =< 0) ->
    {error, "all side lengths must be positive"};
kind(A,B,C) when not ((A < (B + C)) and (B < (A + C)) and (C < (A + B))) ->
    {error, "side lengths violate triangle inequality"};
kind(A,A,A) -> equilateral;
kind(A,_,A) -> isosceles;
kind(A,A,_) -> isosceles;
kind(_,B,B) -> isosceles;
kind(_,_,_) -> scalene.
