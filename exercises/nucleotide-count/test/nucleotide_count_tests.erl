-module(nucleotide_count_tests).

-define(TESTED_MODULE, (sut(nucleotide_count))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


empty_dna_string_has_no_adenine_test() ->
  ?assertEqual(0, ?TESTED_MODULE:count("", "A")).

repetitive_cytosine_gets_counted_test() ->
  ?assertEqual(5, ?TESTED_MODULE:count("CCCCC", "C")).

counts_only_thymine_test() ->
  ?assertEqual(1, ?TESTED_MODULE:count("GGGGGTAACCCGG", "T")).

validates_nucleotides_test() ->
  ?assertException(error, "Invalid nucleotide", ?TESTED_MODULE:count("GACT", "X")).

empty_dna_string_has_no_nucleotides_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 0}], ?TESTED_MODULE:nucleotide_counts("")).

repetitive_sequence_has_only_guanine_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 8}], ?TESTED_MODULE:nucleotide_counts("GGGGGGGG")).

counts_all_nucleotides_test() ->
  ?assertEqual(
     [{"A", 20}, {"T", 21}, {"C", 12}, {"G", 17}],
     ?TESTED_MODULE:nucleotide_counts(
       "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")).
