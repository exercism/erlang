-module(hamming_tests).

-define(TESTED_MODULE, (sut(hamming))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


empty_test()->
  ?assertEqual(0, ?TESTED_MODULE:hamming_distance("", "")).

equal_test() ->
  ?assertEqual(0, ?TESTED_MODULE:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACTAACGGGAT")).

all_different_test() ->
  ?assertEqual(17, ?TESTED_MODULE:hamming_distance("GAGCCTACTAACGGGAT", "FFFFFFFFFFFFFFFFF")).

ends_different_test()->
  ?assertEqual(2, ?TESTED_MODULE:hamming_distance("GAGCCTACTAACGGGAT", "TAGCCTACTAACGGGAG")).

middle_different_test() ->
  ?assertEqual(1, ?TESTED_MODULE:hamming_distance("GAGCCTACTAACGGGAT", "GAGCCTACCAACGGGAT")).

some_differences_test() ->
  ?assertEqual(6, ?TESTED_MODULE:hamming_distance("GAGCCTACTAACGGGAT", "GAACCTCCCAAGGGATT")).
