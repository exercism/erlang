-module(dna_tests).

-include_lib("eunit/include/eunit.hrl").

empty_dna_string_has_no_adenine_test() ->
    ?assertEqual(dna:count("", "A"), 0).

repetitive_cytosine_gets_counted_test() ->
    ?assertEqual(dna:count("CCCCC", "C"), 5).

counts_only_thymine_test() ->
    ?assertEqual(dna:count("GGGGGTAACCCGG", "T"), 1).

validates_nucleotides_test() ->
    ?assertException(error, "Invalid nucleotide", dna:count("GACT", "X")).

empty_dna_string_has_no_nucleotides_test() ->
    ?assertEqual(dna:nucleotide_counts(""),
                 [{"A", 0}, {"T", 0}, {"C", 0}, {"G", 0}]).

repetitive_sequence_has_only_guanine_test() ->
    ?assertEqual(dna:nucleotide_counts("GGGGGGGG"),
                 [{"A", 0}, {"T", 0}, {"C", 0}, {"G", 8}]).

counts_all_nucleotides_test() ->
    ?assertEqual(dna:nucleotide_counts("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"),
                 [{"A", 20}, {"T", 21}, {"C", 12}, {"G", 17}]).
