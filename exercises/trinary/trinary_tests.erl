-module(trinary_tests).
-include_lib("eunit/include/eunit.hrl").

% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(trinary, [verbose])" -s init stop

trinary_1_is_decimal_1_test() ->
  ?assertEqual(1, trinary:to_decimal("1")).

trinary_2_is_decimal_2_test() ->
  ?assertEqual(2, trinary:to_decimal("2")).

trinary_10_is_decimal_3_test() ->
  ?assertEqual(3, trinary:to_decimal("10")).

trinary_11_is_decimal_4_test() ->
  ?assertEqual(4, trinary:to_decimal("11")).

trinary_100_is_decimal_9_test() ->
  ?assertEqual(9, trinary:to_decimal("100")).

trinary_112_is_decimal_14_test() ->
  ?assertEqual(14, trinary:to_decimal("112")).

trinary_222_is_decimal_26_test() ->
  ?assertEqual(26, trinary:to_decimal("222")).

trinary_1120_is_decimal_42_test() ->
  ?assertEqual(42, trinary:to_decimal("1120")).

trinary_1122000120_is_decimal_32091_test() ->
  ?assertEqual(32091, trinary:to_decimal("1122000120")).

invalid_trinary_is_decimal_0_test() ->
  ?assertEqual(0, trinary:to_decimal("carrot")).

