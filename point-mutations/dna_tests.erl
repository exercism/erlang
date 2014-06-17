-module( dna_tests ).

-include_lib("eunit/include/eunit.hrl").


no_difference_between_empty_strands_test() ->
  ?assertEqual(0, dna:hamming_distance("", "")).

no_difference_between_identical_strands_test() ->
  ?assertEqual(0, dna:hamming_distance("GGACTGA", "GGACTGA")).

hamming_distance_in_off_by_one_strand_test() ->
  ?assertEqual(19, dna:hamming_distance("GGACGGATTCTGACCTGGACTAATTTTGGGG",
                                        "AGGACGGATTCTGACCTGGACTAATTTTGGGG")).

small_hamming_distance_in_middle_somewhere_test() ->
  ?assertEqual(1, dna:hamming_distance("GGACG", "GGTCG")).

langer_distance_test() ->
  ?assertEqual(2 , dna:hamming_distance("ACCAGGG", "ACTATGG")).

ignores_extra_length_on_other_strand_when_longer_test()->
  ?assertEqual(3, dna:hamming_distance("AAACTAGGGG", "AGGCTAGCGGTAGGAC")).

ignores_extra_length_on_original_strand_when_longer_test() ->
  ?assertEqual(5, dna:hamming_distance("GACTACGGACAGGGTAGGGAAT", "GACATCGCACACC")).
