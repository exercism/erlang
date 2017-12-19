-module(raindrops_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

% test cases adapted from `x-common//canonical-data.json` @ version: 1.0.0

sound_of_1_is_1_test() ->
    ?assert( raindrops:convert(1) =:= "1").
sound_of_3_is_Pling_test() ->
    ?assert( raindrops:convert(3) =:= "Pling").
sound_of_5_is_Plang_test() ->
    ?assert( raindrops:convert(5) =:= "Plang").
sound_of_7_is_Plong_test() ->
    ?assert( raindrops:convert(7) =:= "Plong").

sound_of_6_is_Pling_test() ->
    ?assert( raindrops:convert(6) =:= "Pling").
sound_of_2_to_the_power_3_is_8_test() ->
    ?assert( raindrops:convert(8) =:= "8").
sound_of_9_is_Pling_test() ->
    ?assert( raindrops:convert(9) =:= "Pling").
sound_of_10_is_Plang_test() ->
    ?assert( raindrops:convert(10) =:= "Plang").
sound_of_14_is_Plong_test() ->
    ?assert( raindrops:convert(14) =:= "Plong").

sound_of_15_is_PlingPlang_test() ->
    ?assert( raindrops:convert(15) =:= "PlingPlang").
sound_of_21_is_PlingPlong_test() ->
    ?assert( raindrops:convert(21) =:= "PlingPlong").
sound_of_25_is_Plang_test() ->
    ?assert( raindrops:convert(25) =:= "Plang").

sound_of_27_is_Pling_test() ->
    ?assert( raindrops:convert(27) =:= "Pling").
sound_of_35_is_PlangPlong_test() ->
    ?assert( raindrops:convert(35) =:= "PlangPlong").
sound_of_49_is_Plong_test() ->
    ?assert( raindrops:convert(49) =:= "Plong").

sound_of_52_is_52_test() ->
    ?assert( raindrops:convert(52) =:= "52").
sound_of_105_is_PlingPlangPlong_test() ->
    ?assert( raindrops:convert(105) =:= "PlingPlangPlong").
sound_of_3125_is_Plang_test() ->
    ?assert( raindrops:convert(3125) =:= "Plang").

version_test() ->
  ?assertMatch(1, raindrops:test_version()).
