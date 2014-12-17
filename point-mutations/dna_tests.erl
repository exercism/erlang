-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_test()->
        ?assertEqual(dna:hamming_distance("", ""), 0).

equal_test() ->
    ?assertEqual(dna:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACTAACGGGAT"), 0).

all_different_test() ->
    ?assertEqual(dna:hamming_distance("GAGCCTACTAACGGGAT", "FFFFFFFFFFFFFFFFF"), 17).

ends_different_test()->
        ?assertEqual(dna:hamming_distance("GAGCCTACTAACGGGAT", "TAGCCTACTAACGGGAG"), 2).

middle_different_test() ->
    ?assertEqual(dna:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACCAACGGGAT"), 1).

some_differences_test() ->
    ?assertEqual(dna:hamming_distance("GAGCCTACTAACGGGAT", "GAACCTCCCAAGGGATT"), 6).
