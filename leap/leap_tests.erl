% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(leap, [verbose])" -s init stop
%

-module(leap_tests).

-include_lib("eunit/include/eunit.hrl").

leap_year_test() ->
    ?assert(leap:leap_year(1996)).

non_leap_year_test() ->
    ?assertNot(leap:leap_year(1997)).

century_test() ->
    ?assertNot(leap:leap_year(1900)).

fourth_century_test() ->
    ?assert(leap:leap_year(2400)).
