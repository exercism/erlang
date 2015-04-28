-module(grains_tests).
-include_lib("eunit/include/eunit.hrl").

% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(grains, [verbose])" -s init stop

square_1_test() ->
  ?assertEqual(1, grains:square(1)).

square_2_test() ->
  ?assertEqual(2, grains:square(2)).

square_3_test() ->
  ?assertEqual(4, grains:square(3)).

square_4_test() ->
  ?assertEqual(8, grains:square(4)).

square_16_test() ->
  ?assertEqual(32768, grains:square(16)).

square_32_test() ->
  ?assertEqual(2147483648, grains:square(32)).

square_64_test() ->
  ?assertEqual(9223372036854775808, grains:square(64)).

total_grains_test() ->
  ?assertEqual(18446744073709551615, grains:total()).

