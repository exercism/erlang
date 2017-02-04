-module( parallel_letter_frequency_tests ).

-define(TESTED_MODULE, (sut(parallel_letter_frequency))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


single_test() ->
  Frequencies = dict:to_list( ?TESTED_MODULE:dict(["asd"]) ),
  ?assert( lists:sort(Frequencies) =:= [{$a,1},{$d,1},{$s,1}] ).

double_test() ->
  Frequencies = dict:to_list( ?TESTED_MODULE:dict(["asd", "asd"]) ),
  ?assert( lists:sort(Frequencies) =:= [{$a,2},{$d,2},{$s,2}] ).
