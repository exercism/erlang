% To run tests:
% elc *.erl
% erl -noshell -eval "eunit:test(phone, [verbose])" -s init stop
%
-module(phone_tests).

-include_lib("eunit/include/eunit.hrl").

cleans_number_test() ->
  ?assertEqual("1234567890", phone:number("(123) 456-7890")).

cleans_number_with_dots_test() ->
  ?assertEqual("1234567890", phone:number("123.456.7890")).

valid_when_eleven_digits_test() ->
  ?assertEqual("1234567890", phone:number("11234567890")).

invalid_when_eleven_digits_test() ->
  ?assertEqual("0000000000", phone:number("21234567890")).

invalid_when_nine_digits_test() ->
  ?assertEqual("0000000000", phone:number("123456789")).

area_code_test() ->
  ?assertEqual("123", phone:areacode("1234567890")).

pretty_print_test() ->
  ?assertEqual("(123) 456-7890", phone:pretty_print("1234567890")),
  ?assertEqual("(123) 456-7890", phone:pretty_print("11234567890")).
