-module(dna).

-export([hamming_distance/2]).

hamming_distance([], _) ->
  0;
hamming_distance(_, []) ->
  0;
hamming_distance([A|As], [A|Bs]) ->
  hamming_distance(As, Bs);
hamming_distance([_|As], [_|Bs]) ->
  1 + hamming_distance(As, Bs).
