-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_dna_string_has_no_adenine_test() ->
  ?assertEqual(0, dna:count("", "A")).

repetitive_cytosine_gets_counted_test() ->
  ?assertEqual(5, dna:count("CCCCC", "C")).

counts_only_thymine_test() ->
  ?assertEqual(1, dna:count("GGGGGTAACCCGG", "T")).

validates_nucleotides_test() ->
  ?assertException(error, "Invalid nucleotide", dna:count("GACT", "X")).

empty_dna_string_has_no_nucleotides_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 0}], dna:nucleotide_counts("")).

repetitive_sequence_has_only_guanine_test() ->
  ?assertEqual([{"A", 0}, {"T", 0}, {"C", 0}, {"G", 8}], dna:nucleotide_counts("GGGGGGGG")).

counts_all_nucleotides_test() ->
  ?assertEqual(
     [{"A", 20}, {"T", 21}, {"C", 12}, {"G", 17}],
     dna:nucleotide_counts(
       "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")).
