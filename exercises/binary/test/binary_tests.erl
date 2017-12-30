-module(binary_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


one_test() -> check( "1" ).

two_test() -> check( "10" ).

three_test() -> check( "11" ).

four_test() -> check( "100" ).

nine_test() -> check( "1001" ).

twenty_six_test() -> check( "11010" ).

large_test() -> check( "10001101000" ).

carrot_test() ->
  ?assert(0 =:= binary:to_decimal( "carrot" )).

check(String) ->
  ?assert(binary:to_decimal(String) =:= erlang:list_to_integer(String, 2)).

version_test() ->
  ?assertMatch(1, binary:test_version()).
