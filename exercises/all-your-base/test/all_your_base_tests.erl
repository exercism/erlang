-module(all_your_base_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

single_bit_one_to_decimal_test() ->
  ?assertMatch({ok, [1]}, all_your_base:convert([1], 2, 10)).

binary_to_single_decimal_test() ->
  ?assertMatch({ok, [5]}, all_your_base:convert([1, 0, 1], 2, 10)).

single_decimal_to_binary_test() ->
  ?assertMatch({ok, [1, 0, 1]}, all_your_base:convert([5], 10, 2)).

binary_to_multiple_decimal_test() ->
  ?assertMatch({ok, [4, 2]}, all_your_base:convert([1, 0, 1, 0, 1, 0], 2, 10)).

decimal_to_binary_test() ->
  ?assertMatch({ok, [1, 0, 1, 0, 1, 0]}, all_your_base:convert([4, 2], 10, 2)).

trinary_to_hexadecimal_test() ->
  ?assertMatch({ok, [2, 10]}, all_your_base:convert([1, 1, 2, 0], 3, 16)).

hexadecimal_to_trinary_test() ->
  ?assertMatch({ok, [1, 1, 2, 0]}, all_your_base:convert([2, 10], 16, 3)).

fifteen_bit_integer_test() ->
  ?assertMatch({ok, [6,10,45]}, all_your_base:convert([3,46,60], 97, 73)).

empty_list_test() ->
  ?assertMatch({ok, []}, all_your_base:convert([], 2, 10)).

single_zero_test() ->
  ?assertMatch({ok, []}, all_your_base:convert([0], 10, 2)).

multiple_zero_test() ->
  ?assertMatch({ok, []}, all_your_base:convert([0, 0, 0], 10, 2)).

leading_zero_test() ->
  ?assertMatch({ok, [4, 2]}, all_your_base:convert([0, 6, 0], 7, 10)).

negative_digit_test() ->
  ?assertMatch({error, negative}, all_your_base:convert([1, -1, 1, 0, 1, 0], 2, 10)).

invalid_positiv_digit_test() ->
  ?assertMatch({error, not_in_base}, all_your_base:convert([1, 2, 1, 0, 1, 0], 2, 10)).

first_base_is_one_test() ->
  ?assertMatch({error, invalid_src_base}, all_your_base:convert([], 1, 10)).

second_base_is_one_test() ->
  ?assertMatch({error, invalid_dst_base}, all_your_base:convert([1, 0, 1, 0, 1, 0], 2, 1)).

first_base_is_zero_test() ->
  ?assertMatch({error, invalid_src_base}, all_your_base:convert([], 0, 10)).

second_base_is_zero_test() ->
  ?assertMatch({error, invalid_dst_base}, all_your_base:convert([7], 10, 0)).

first_base_is_negative_test() ->
  ?assertMatch({error, invalid_src_base}, all_your_base:convert([1], -2, 10)).

second_base_is_negative_test() ->
  ?assertMatch({error, invalid_dst_base}, all_your_base:convert([1], 2, -7)).

both_bases_are_negative_test() ->
  {error, Reason} = all_your_base:convert([1], -2, -7),
  ?assert(lists:member(Reason, [invalid_dst_base, invalid_src_base])).

version_test() ->
  ?assertMatch(1, all_your_base:test_version()).
