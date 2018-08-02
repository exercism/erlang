%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/run-length-encoding/canonical-data.json

-module(run_length_encoding_tests).

-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

encode_empty_string_test() ->
	?assertMatch("", run_length_encoding:encode("")).

encode_single_characters_only_test() ->
	?assertMatch("XYZ", run_length_encoding:encode("XYZ")).

encode_no_single_characters_test() ->
	?assertMatch("2A3B4C", run_length_encoding:encode("AABBBCCCC")).

encode_single_characters_mixed_with_repeated_characters_test() ->
	?assertMatch("12WB12W3B24WB", run_length_encoding:encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")).

encode_multiple_whitespace_test() ->
	?assertMatch("2 hs2q q2w2 ", run_length_encoding:encode("  hsqq qww  ")).

encode_lowercase_characters_test() ->
	?assertMatch("2a3b4c", run_length_encoding:encode("aabbbcccc")).

decode_empty_string_test() ->
	?assertMatch("", run_length_encoding:decode("")).

decode_single_characters_only_test() ->
	?assertMatch("XYZ", run_length_encoding:decode("XYZ")).

decode_no_single_characters_test() ->
	?assertMatch("AABBBCCCC", run_length_encoding:decode("2A3B4C")).

decode_single_characters_mixed_with_repeated_characters_test() ->
	?assertMatch("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB", run_length_encoding:decode("12WB12W3B24WB")).

decode_multiple_whitespace_test() ->
	?assertMatch("  hsqq qww  ", run_length_encoding:decode("2 hs2q q2w2 ")).

decode_lowercase_characters_test() ->
	?assertMatch("aabbbcccc", run_length_encoding:decode("2a3b4c")).

encode_decode_test() ->
	String="zzz ZZ  zZ",
	?assertMatch(String, run_length_encoding:decode(run_length_encoding:encode(String))).

version_test() ->
	?assertMatch(?TEST_VERSION, run_length_encoding:test_version()).
