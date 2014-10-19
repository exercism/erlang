-module( nucleotide_count_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

empty_dna_string_has_no_adenosine_test() ->
    ?assertEqual( nucleotide_count:count("", "A"), 0 ).

repetitive_cytidine_gets_counted_test() ->
    ?assertEqual( nucleotide_count:count("CCCCC", "C"), 5 ).

counts_only_thymidine_test() ->
    ?assertEqual( nucleotide_count:count("GGGGGTAACCCGG", "T"), 1 ).

dna_has_no_uracil_test() ->
    ?assertEqual( nucleotide_count:count("GATTACA", "U"), 0 ).

validates_nucleotides_test() ->
    ?assertException( error, "Invalid nucleotide", nucleotide_count:count("GACX", "X") ).

empty_dna_string_has_no_nucleotides_test() ->
    ?assertEqual( nucleotide_count:dna(""), {{"A", 0}, {"T", 0}, {"C", 0}, {"G", 0}} ).

repetitive_sequence_has_only_guanosine_test() ->
    ?assertEqual( nucleotide_count:dna("GGGGGGGG"), {{"A", 0}, {"T", 0}, {"C", 0}, {"G", 8}} ).

counts_all_nucleotides_test() ->
    ?assertEqual( nucleotide_count:dna("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"),
                 {{"A", 20}, {"T", 21}, {"C", 12}, {"G", 17}} ).
