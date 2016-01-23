-module(gigasecond_tests).
-include_lib("eunit/include/eunit.hrl").

% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(gigasecond, [verbose])" -s init stop

one_test() ->
  Gs = gigasecond:from({2011, 4, 25}),
  ?assertEqual({{2043, 1, 1}, {1, 46, 40}}, Gs).

two_test() ->
  Gs = gigasecond:from({1977, 6, 13}),
  ?assertEqual({{2009, 2, 19}, {1, 46, 40}}, Gs).

three_test() ->
  Gs = gigasecond:from({1959, 7, 19}),
  ?assertEqual({{1991, 3, 27}, {1, 46, 40}}, Gs).

four_with_seconds_test() ->
  Gs = gigasecond:from({{1959, 7, 19}, {23, 59, 59}}),
  ?assertEqual({{1991, 3, 28}, {1, 46, 39}}, Gs).

% modify the test to test your 1 Gs anniversary
% with_your_birthday_test() ->
%   YourBirthday = {Year, Month, Day},
%   Gs = gigasecond:from(YourBirthday),
%   ?assertEqual({2009, 1, 31, 1, 46, 39}, Gs).

