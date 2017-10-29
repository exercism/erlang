-module(hamming_tests).

-define(TESTED_MODULE, (sut(hamming))).
-define(TEST_VERSION, 2).
-include("exercism.hrl").


empty_strands_test() ->
    ?assertMatch(0, ?TESTED_MODULE:distance([], [])).

identical_strands_test() ->
    ?assertMatch(0, ?TESTED_MODULE:distance("A", "A")).

long_identical_strands_test() ->
    ?assertMatch(0,
		 ?TESTED_MODULE:distance("GGACTGA", "GGACTGA")).

complete_distance_in_single_nucleotide_strands_test() ->
    ?assertMatch(1, ?TESTED_MODULE:distance("A", "G")).

complete_distance_in_small_strands_test() ->
    ?assertMatch(2, ?TESTED_MODULE:distance("AG", "CT")).

small_distance_in_small_strands_test() ->
    ?assertMatch(1, ?TESTED_MODULE:distance("AT", "CT")).

small_distance_test() ->
    ?assertMatch(1,
		 ?TESTED_MODULE:distance("GGACG", "GGTCG")).

small_distance_in_long_strands_test() ->
    ?assertMatch(2,
		 ?TESTED_MODULE:distance("ACCAGGG", "ACTATGG")).

non_unique_character_in_first_strand_test() ->
    ?assertMatch(1, ?TESTED_MODULE:distance("AAG", "AAA")).

non_unique_character_in_second_strand_test() ->
    ?assertMatch(1, ?TESTED_MODULE:distance("AAA", "AAG")).

same_nucleotides_in_different_positions_test() ->
    ?assertMatch(2, ?TESTED_MODULE:distance("TAG", "GAT")).

large_distance_test() ->
    ?assertMatch(4,
		 ?TESTED_MODULE:distance("GATACA", "GCATAA")).

large_distance_in_off_by_one_strand_test() ->
    ?assertMatch(9,
		 ?TESTED_MODULE:distance("GGACGGATTCTG",
					 "AGGACGGATTCT")).

disallow_first_strand_longer_test() ->
    ?assertMatch({error,
		  "left and right strands must be of equal "
		  "length"},
		 ?TESTED_MODULE:distance("AATG", "AAA")).

disallow_second_strand_longer_test() ->
    ?assertMatch({error,
		  "left and right strands must be of equal "
		  "length"},
		 ?TESTED_MODULE:distance("ATA", "AGTG")).
