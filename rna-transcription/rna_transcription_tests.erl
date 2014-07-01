-module( rna_transcription_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

transcribes_cytidine_unchanged_test() ->
  ?assertEqual( "C", rna_transcription:from_dna("C") ).

transcribes_guanosine_unchanged_test() ->
  ?assertEqual( "G", rna_transcription:from_dna("G") ).

transcribes_adenosine_unchanged_test() ->
  ?assertEqual("A", rna_transcription:from_dna("A") ).

transcribes_thymidine_to_uracil_test() ->
  ?assertEqual( "U", rna_transcription:from_dna("T") ).

transcribes_all_occurences_test() ->
  ?assertEqual( "ACGUGGUCUUAA", rna_transcription:from_dna("ACGTGGTCTTAA") ).
