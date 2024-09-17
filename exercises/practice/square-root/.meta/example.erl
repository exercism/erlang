-module(example).

-export([square_root/1]).


square_root(1) ->
    1;
square_root(Radicand) ->
    square_root(Radicand, Radicand div 2).
square_root(Radicand, Guess) when (Guess * Guess) =:= Radicand ->
    Guess;
square_root(Radicand, Guess) ->
    square_root(Radicand, (Guess + Radicand div Guess) div 2).
