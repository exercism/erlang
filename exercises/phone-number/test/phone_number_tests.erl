-module(phone_number_tests).

-define(TESTED_MODULE, (sut(phone_number))).
-define(TEST_VERSION, 1).
-include("exercism.hrl").


cleans_number_test() ->
  ?assertEqual("1234567890", ?TESTED_MODULE:number("(123) 456-7890")).

cleans_number_with_dots_test() ->
  ?assertEqual("1234567890", ?TESTED_MODULE:number("123.456.7890")).

valid_when_eleven_digits_test() ->
  ?assertEqual("1234567890", ?TESTED_MODULE:number("11234567890")).

invalid_when_eleven_digits_test() ->
  ?assertEqual("0000000000", ?TESTED_MODULE:number("21234567890")).

invalid_when_nine_digits_test() ->
  ?assertEqual("0000000000", ?TESTED_MODULE:number("123456789")).

area_code_test() ->
  ?assertEqual("123", ?TESTED_MODULE:areacode("1234567890")).

pretty_print_test() ->
  ?assertEqual("(123) 456-7890", ?TESTED_MODULE:pretty_print("1234567890")),
  ?assertEqual("(123) 456-7890", ?TESTED_MODULE:pretty_print("11234567890")).
