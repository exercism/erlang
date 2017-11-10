-module(nucleotide_count_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

empty_dna_string_has_no_adenine_test() ->
  ?assertEqual(0, nucleotide_count:count("", "A")).

repetitive_cytosine_gets_counted_test() ->
  ?assertEqual(5, nucleotide_count:count("CCCCC", "C")).

counts_only_thymine_test() ->
  ?assertEqual(1, nucleotide_count:count("GGGGGTAACCCGG", "T")).

validates_nucleotides_test() ->
  ?assertException(error, "Invalid nucleotide", nucleotide_count:count("GACT", "X")).

empty_dna_string_has_no_nucleotides_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 0}], nucleotide_count:nucleotide_counts("")).

repetitive_sequence_has_only_guanine_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 8}], nucleotide_count:nucleotide_counts("GGGGGGGG")).

counts_all_nucleotides_test() ->
  ?assertEqual(
     [{"A", 20}, {"T", 21}, {"C", 12}, {"G", 17}],
     nucleotide_count:nucleotide_counts(
       "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")).

version_test() ->
  ?assertMatch(1, nucleotide_count:test_version()).
