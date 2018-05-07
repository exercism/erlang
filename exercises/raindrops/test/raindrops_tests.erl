-module(raindrops_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

sound_of_1_is_1_test() ->
    ?assertEqual("1", raindrops:convert(1)).

sound_of_3_is_Pling_test() ->
    ?assertEqual("Pling", raindrops:convert(3)).

sound_of_5_is_Plang_test() ->
    ?assertEqual("Plang", raindrops:convert(5)).

sound_of_7_is_Plong_test() ->
    ?assertEqual("Plong", raindrops:convert(7)).

sound_of_6_is_Pling_test() ->
    ?assertEqual("Pling", raindrops:convert(6)).

sound_of_2_to_the_power_3_is_8_test() ->
    ?assertEqual("8", raindrops:convert(8)).

sound_of_9_is_Pling_test() ->
    ?assertEqual("Pling", raindrops:convert(9)).

sound_of_10_is_Plang_test() ->
    ?assertEqual("Plang", raindrops:convert(10)).

sound_of_14_is_Plong_test() ->
    ?assertEqual("Plong", raindrops:convert(14)).

sound_of_15_is_PlingPlang_test() ->
    ?assertEqual("PlingPlang", raindrops:convert(15)).

sound_of_21_is_PlingPlong_test() ->
    ?assertEqual("PlingPlong", raindrops:convert(21)).

sound_of_25_is_Plang_test() ->
    ?assertEqual("Plang", raindrops:convert(25)).

sound_of_27_is_Pling_test() ->
    ?assertEqual("Pling", raindrops:convert(27)).

sound_of_35_is_PlangPlong_test() ->
    ?assertEqual("PlangPlong", raindrops:convert(35)).

sound_of_49_is_Plong_test() ->
    ?assertEqual("Plong", raindrops:convert(49)).

sound_of_52_is_52_test() ->
    ?assertEqual("52", raindrops:convert(52)).

sound_of_105_is_PlingPlangPlong_test() ->
    ?assertEqual("PlingPlangPlong", raindrops:convert(105)).

sound_of_3125_is_Plang_test() ->
    ?assertEqual("Plang", raindrops:convert(3125)).

version_test() ->
  ?assertEqual(1, raindrops:test_version()).
