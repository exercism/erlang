-module(dna).

-export([hammingDistance/2]).

hammingDistance("", "") ->
  0;
hammingDistance([A|As], [A|Bs]) ->
  hammingDistance(As, Bs);
hammingDistance([_|As], [_|Bs]) ->
  1 + hammingDistance(As, Bs).
