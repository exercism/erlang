-module(phone_number_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

cleans_number_test() ->
  ?assertEqual("1234567890", phone_number:number("(123) 456-7890")).

cleans_number_with_dots_test() ->
  ?assertEqual("1234567890", phone_number:number("123.456.7890")).

valid_when_eleven_digits_test() ->
  ?assertEqual("1234567890", phone_number:number("11234567890")).

invalid_when_eleven_digits_test() ->
  ?assertEqual("0000000000", phone_number:number("21234567890")).

invalid_when_nine_digits_test() ->
  ?assertEqual("0000000000", phone_number:number("123456789")).

area_code_test() ->
  ?assertEqual("123", phone_number:areacode("1234567890")).

pretty_print_test() ->
  ?assertEqual("(123) 456-7890", phone_number:pretty_print("1234567890")),
  ?assertEqual("(123) 456-7890", phone_number:pretty_print("11234567890")).

version_test() ->
  ?assertMatch(1, phone_number:test_version()).
