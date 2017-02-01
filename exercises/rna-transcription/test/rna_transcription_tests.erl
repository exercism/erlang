-module(rna_transcription_tests).

-include("exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(TESTED_MODULE, (sut(rna_transcription))).

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
