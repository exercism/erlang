% to run tests:
% erl -make
% erl -noshell -eval "eunit:test(rna_transcription, [verbose])" -s init stop

-module(rna_transcription_tests).
-include_lib("eunit/include/eunit.hrl").

transcribes_cytidine_unchanged_test() ->
  ?assertEqual("C", rna_transcription:from_dna("G")).

transcribes_guanosine_unchanged_test() ->
  ?assertEqual("G", rna_transcription:from_dna("C")).

transcribes_adenosine_unchanged_test() ->
  ?assertEqual("A", rna_transcription:from_dna("T")).

transcribes_thymidine_to_uracil_test() ->
  ?assertEqual("U", rna_transcription:from_dna("A")).

transcribes_all_occurences_test() ->
  ?assertEqual(
      "UGCACCAGAAUU",
      rna_transcription:from_dna("ACGTGGTCTTAA")
  ).
