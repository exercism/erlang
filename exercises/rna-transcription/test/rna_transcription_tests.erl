-module(rna_transcription_tests).

-define(TESTED_MODULE, (sut(rna_transcription))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


transcribes_cytidine_unchanged_test() ->
  ?assertEqual("C", ?TESTED_MODULE:to_rna("G")).

transcribes_guanosine_unchanged_test() ->
  ?assertEqual("G", ?TESTED_MODULE:to_rna("C")).

transcribes_adenosine_unchanged_test() ->
  ?assertEqual("A", ?TESTED_MODULE:to_rna("T")).

transcribes_thymidine_to_uracil_test() ->
  ?assertEqual("U", ?TESTED_MODULE:to_rna("A")).

transcribes_all_occurences_test() ->
  ?assertEqual(
     "UGCACCAGAAUU",
     ?TESTED_MODULE:to_rna("ACGTGGTCTTAA")
    ).
