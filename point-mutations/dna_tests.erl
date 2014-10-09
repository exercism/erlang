-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_test()->
        ?assertEqual(dna:hamming("", ""), 0).

equal_test() ->
    ?assertEqual(dna:hamming("GAGCCTACTAACGGGAT", "GAGCCTACTAACGGGAT"), 0).

all_different_test() ->
    ?assertEqual(dna:hamming("GAGCCTACTAACGGGAT", "FFFFFFFFFFFFFFFFF"), 17).

ends_different_test()->
        ?assertEqual(dna:hamming("GAGCCTACTAACGGGAT", "TAGCCTACTAACGGGAG"), 2).

middle_different_test() ->
    ?assertEqual(dna:hamming("GAGCCTACTAACGGGAT", "GAGCCTACCAACGGGAT"), 1).

some_differences_test() ->
    ?assertEqual(dna:hamming("GAGCCTACTAACGGGAT", "GAACCTCCCAAGGGATT"), 6).




    
