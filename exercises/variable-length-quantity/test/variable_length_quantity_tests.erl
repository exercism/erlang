%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/variable-length-quantity/canonical-data.json

-module(variable_length_quantity_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

encode_zero_test() ->
	Input=[0],
	Expected=[0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_arbitrary_single_byte_test() ->
	Input=[64],
	Expected=[64],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_largest_single_byte_test() ->
	Input=[127],
	Expected=[127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_smallest_double_byte_test() ->
	Input=[128],
	Expected=[129,0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_arbitrary_double_byte_test() ->
	Input=[8192],
	Expected=[192, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_largest_double_byte_test() ->
	Input=[16383],
	Expected=[255, 127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_smallest_triple_byte_test() ->
	Input=[16384],
	Expected=[129, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_arbitrary_triple_byte_test() ->
	Input=[1048576],
	Expected=[192, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_largest_triple_byte_test() ->
	Input=[2097151],
	Expected=[255, 255, 127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_smallest_quadruple_byte_test() ->
	Input=[2097152],
	Expected=[129, 128, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_arbitrary_quadruple_byte_test() ->
	Input=[134217728],
	Expected=[192, 128, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_largest_quadruple_byte_test() ->
	Input=[268435455],
	Expected=[255, 255, 255, 127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_smallest_quintuple_byte_test() ->
	Input=[268435456],
	Expected=[129, 128, 128, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_arbitrary_quintuple_byte_test() ->
	Input=[4278190080],
	Expected=[143, 248, 128, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_maximum_32bit_integer_input_test() ->
	Input=[4294967295],
	Expected=[143, 255, 255, 255, 127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_two_single_byte_values_test() ->
	Input=[64, 127],
	Expected=[64, 127],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_two_multi_byte_values_test() ->
	Input=[16384, 1193046],
	Expected=[129, 128, 0, 200, 232, 86],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

encode_many_multi_byte_values_test() ->
	Input=[8192, 1193046, 268435455, 0, 16383, 16384],
	Expected=[192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0],
	?assertMatch(Expected, variable_length_quantity:encode(Input)).

decode_one_byte_test() ->
	Input=[127],
	Expected=[127],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_two_bytes_test() ->
	Input=[192, 0],
	Expected=[8192],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_three_bytes_test() ->
	Input=[255, 255, 127],
	Expected=[2097151],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_four_bytes_test() ->
	Input=[129, 128, 128, 0],
	Expected=[2097152],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_maximum_32bit_integer_test() ->
	Input=[143, 255, 255, 255, 127],
	Expected=[4294967295],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_incomplete_sequence_causes_error_test() ->
	Input=[255],
	Expected=undefined,
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_incomplete_sequence_causes_error_even_if_value_is_zero_test() ->
	Input=[128],
	Expected=undefined,
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

decode_multiple_values_test() ->
	Input=[192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0] ,
	Expected=[8192, 1193046, 268435455, 0, 16383, 16384],
	?assertMatch(Expected, variable_length_quantity:decode(Input)).

