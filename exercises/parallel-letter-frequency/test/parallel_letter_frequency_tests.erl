-module( parallel_letter_frequency_tests ).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

single_test() ->
  Frequencies = dict:to_list( parallel_letter_frequency:dict(["asd"]) ),
  ?assert( lists:sort(Frequencies) =:= [{$a,1},{$d,1},{$s,1}] ).

double_test() ->
  Frequencies = dict:to_list( parallel_letter_frequency:dict(["asd", "asd"]) ),
  ?assert( lists:sort(Frequencies) =:= [{$a,2},{$d,2},{$s,2}] ).
