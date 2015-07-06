-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_test()->
  ?assertEqual(0, dna:hamming_distance("", "")).

equal_test() ->
  ?assertEqual(0, dna:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACTAACGGGAT")).

all_different_test() ->
  ?assertEqual(17, dna:hamming_distance("GAGCCTACTAACGGGAT", "FFFFFFFFFFFFFFFFF")).

ends_different_test()->
  ?assertEqual(2, dna:hamming_distance("GAGCCTACTAACGGGAT", "TAGCCTACTAACGGGAG")).

middle_different_test() ->
  ?assertEqual(1, dna:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACCAACGGGAT")).

some_differences_test() ->
  ?assertEqual(6, dna:hamming_distance("GAGCCTACTAACGGGAT", "GAACCTCCCAAGGGATT")).
