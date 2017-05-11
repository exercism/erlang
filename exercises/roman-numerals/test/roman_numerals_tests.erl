-module(roman_numerals_tests).

-define(TESTED_MODULE, (sut(roman_numerals))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


expect_roman(Number, Expected) ->
  ?assertEqual(Expected, ?TESTED_MODULE:numerals(Number)).

convert_1_test() -> expect_roman(1, "I").

convert_2_test() -> expect_roman(2, "II").

convert_3_test() -> expect_roman(3, "III").

convert_4_test() -> expect_roman(4, "IV").

convert_5_test() -> expect_roman(5, "V").

convert_6_test() -> expect_roman(6, "VI").

convert_9_test() -> expect_roman(9, "IX").

convert_27_test() -> expect_roman(27, "XXVII").

convert_48_test() -> expect_roman(48, "XLVIII").

convert_59_test() -> expect_roman(59, "LIX").

convert_93_test() -> expect_roman(93, "XCIII").

convert_141_test() -> expect_roman(141, "CXLI").

convert_163_test() -> expect_roman(163, "CLXIII").

convert_402_test() -> expect_roman(402, "CDII").

convert_575_test() -> expect_roman(575, "DLXXV").

convert_911_test() -> expect_roman(911, "CMXI").

convert_1024_test() -> expect_roman(1024, "MXXIV").

convert_3000_test() -> expect_roman(3000, "MMM").
