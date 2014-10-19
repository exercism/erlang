-module( leap_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

one_test() -> ?assert( leap:is_leap_year(1996) ).

two_test() -> ?assert( leap:is_leap_year(2000) ).

three_test() -> ?assertNot( leap:is_leap_year(1900) ).

four_test() -> ?assertNot( leap:is_leap_year(1997) ).

