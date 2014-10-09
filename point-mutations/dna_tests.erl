-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_test()->
        ?assertEqual(dna:hammingDistance("", ""), 0).

equal_test() ->
    ?assertEqual(dna:hammingDistance("GAGCCTACTAACGGGAT", "GAGCCTACTAACGGGAT"), 0).

all_different_test() ->
    ?assertEqual(dna:hammingDistance("GAGCCTACTAACGGGAT", "FFFFFFFFFFFFFFFFF"), 17).

ends_different_test()->
        ?assertEqual(dna:hammingDistance("GAGCCTACTAACGGGAT", "TAGCCTACTAACGGGAG"), 2).

middle_different_test() ->
    ?assertEqual(dna:hammingDistance("GAGCCTACTAACGGGAT", "GAGCCTACCAACGGGAT"), 1).

some_differences_test() ->
    ?assertEqual(dna:hammingDistance("GAGCCTACTAACGGGAT", "GAACCTCCCAAGGGATT"), 6).




    
